# frozen_string_literal: true

require 'forme'
require 'roda'

require_relative 'models'

# The application class
class LaborExchangeApp < Roda
  opts[:root] = __dir__
  plugin :environments
  plugin :forme
  plugin :render
  plugin :status_handler

  configure :development do
    plugin :public
    opts[:serve_static] = true
  end

  opts[:vacancies] = VacancyList.new
  opts[:vacancies].read_csv(File.expand_path('data/vacancies.csv', __dir__))
  opts[:job_seekers] = JobSeekerList.new
  opts[:job_seekers].read_csv(File.expand_path('data/job_seekers.csv', __dir__))

  status_handler(404) do
    view('not_found')
  end

  route do |r|
    r.public if opts[:serve_static]

    r.root do
      r.redirect '/labor_exchange'
    end

    r.on 'labor_exchange' do
      r.is do
        @statisctics = { "Вакансий:": opts[:vacancies].count_vacancy,
                         "Соискателей:": opts[:job_seekers].count_job_seekers }
        view('labor_exchange')
      end

      r.on 'vacancies' do
        r.is do
          @parameters = r.params
          @vacancies = if @parameters['filter'].nil?
                         opts[:vacancies].all_vacancies
                       else
                         opts[:vacancies].filter_vacansies(@parameters['filter'])
                       end
          view('vacancies')
        end

        r.on Integer do |vacancy_id|
          @vacancy = opts[:vacancies].vacancy_by_id(vacancy_id)
          next if @vacancy.nil?

          r.is do
            view('vacancy')
          end

          r.on 'edit' do
            r.get do
              @parameters = @vacancy.to_h
              view('vacancy_edit')
            end

            r.post do
              @parameters = DryResultFormeWrapper.new(VacancyFormSchema.new.call(r.params))
              if @parameters.success?
                opts[:vacancies].update_vacancy(@vacancy.id, @parameters)
                r.redirect "/labor_exchange/vacancies/#{@vacancy.id}"
              else
                view('vacancy_edit')
              end
            end
          end

          r.on 'delete' do
            r.get do
              @parameters = {}
              view('vacancy_delete')
            end

            r.post do
              @parameters = DryResultFormeWrapper.new(DeleteSchema.call(r.params))
              if @parameters.success?
                opts[:vacancies].delete_vacancy(@vacancy.id)
                r.redirect('/labor_exchange/vacancies')
              else
                view('vacancy_delete')
              end
            end
          end
        end

        r.on 'new' do
          r.get do
            @parameters = {}
            view('vacancy_new')
          end

          r.post do
            @parameters = DryResultFormeWrapper.new(VacancyFormSchema.new.call(r.params))
            if @parameters.success?
              vacancy_id = opts[:vacancies].add_vacancy(@parameters)
              r.redirect "/labor_exchange/vacancies/#{vacancy_id}"
            else
              view('vacancy_new')
            end
          end
        end
      end

      r.on 'positions' do
        @positions = opts[:vacancies].all_positions

        r.is do
          view('positions')
        end

        r.on Integer do |position_id|
          @statisctics = opts[:vacancies].position_statistics(@positions[position_id - 1])
          view('position')
        end
      end

      r.on 'job_seekers' do
        r.is do
          @job_seekers = opts[:job_seekers].all_job_sekeers
          view('job_seekers')
        end

        r.on Integer do |job_seeker_id|
          @job_seeker = opts[:job_seekers].job_seeker_by_id(job_seeker_id)
          next if @job_seeker.nil?

          r.is do
            view('job_seeker')
          end

          r.on 'delete' do
            r.get do
              @parameters = {}
              view('job_seeker_delete')
            end

            r.post do
              @parameters = DryResultFormeWrapper.new(DeleteSchema.call(r.params))
              if @parameters.success?
                opts[:job_seekers].delete_job_seeker(@job_seeker.id)
                r.redirect('/labor_exchange/job_seekers')
              else
                view('job_seeker_delete')
              end
            end
          end

          r.on 'edit' do
            r.get do
              @parameters = @job_seeker.to_h
              view('job_seeker_edit')
            end

            r.post do
              @parameters = DryResultFormeWrapper.new(JobSeekerFormSchema.new.call(r.params))
              if @parameters.success?
                opts[:job_seekers].update_job_seeker(@job_seeker.id, @parameters)
                r.redirect "/labor_exchange/job_seekers/#{@job_seeker.id}"
              else
                view('job_seeker_edit')
              end
            end
          end

          r.on 'search_job' do
            r.is do
              @vacancies = opts[:vacancies].search_job(@job_seeker)
              view('search_job')
            end

            r.on Integer do |vacancy_id|
              @vacancy = opts[:vacancies].vacancy_by_id(vacancy_id)
              next if @vacancy.nil?

              opts[:vacancies].reduce_the_amount(vacancy_id)
              @vacancy.to_file(File.expand_path(
                                 "data/#{@job_seeker.name}_#{@job_seeker.surname}.txt", __dir__
                               ))

              r.redirect "/labor_exchange/job_seekers/#{job_seeker_id}/search_job"
            end
          end

          r.on 'almost_search_job' do
            r.is do
              @vacancies = opts[:vacancies].almost_search_job(@job_seeker)
              view('almost_search_job')
            end

            r.on Integer do |vacancy_id|
              @vacancy = opts[:vacancies].vacancy_by_id(vacancy_id)
              next if @vacancy.nil?

              opts[:vacancies].reduce_the_amount(vacancy_id)
              @vacancy.to_file(File.expand_path(
                                 "data/#{@job_seeker.name}_#{@job_seeker.surname}.txt", __dir__
                               ))

              r.redirect "/labor_exchange/job_seekers/#{job_seeker_id}/almost_search_job"
            end
          end
        end

        r.on 'new' do
          r.get do
            @parameters = {}
            view('job_seeker_new')
          end

          r.post do
            @parameters = DryResultFormeWrapper.new(JobSeekerFormSchema.new.call(r.params))
            if @parameters.success?
              job_seeker_id = opts[:job_seekers].add_job_seeker(@parameters)
              r.redirect "/labor_exchange/job_seekers/#{job_seeker_id}"
            else
              view('job_seeker_new')
            end
          end
        end
      end

      r.on 'age_statistics' do
        r.is do
          @parameters = DryResultFormeWrapper.new(AgeStatisticsSchema.call(r.params))
          if @parameters.success? && !@parameters[:age].nil?
            @statisctics = { "Средняя желательная зарплата":
                            opts[:job_seekers].average_desired_salary_by_age(@parameters[:age]),
                             "Средний возможный оклад":
                            opts[:vacancies].average_possible_salary_by_age(@parameters[:age]) }
          else
            @statisctics = {}
          end
          view('age_statistics')
        end
      end
    end
  end
end
