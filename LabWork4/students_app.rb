# frozen_string_literal: true

require 'roda'

require_relative 'models'

# The core class of the web application for managing test
class StudentsApp < Roda
  opts[:root] = __dir__
  plugin :environments
  plugin :render

  configure :development do
    plugin :public
    opts[:serve_static] = true
  end

  opts[:institutions] = InstituteList.new
  opts[:institutions].read_csv(File.expand_path('data/students.csv', __dir__))
  opts[:flag] = false

  route do |r|
    r.public if opts[:serve_static]

    r.root do
      @params = { institutions: opts[:institutions].all_institute }
      view('institutions')
    end

    r.on 'institute' do
      r.on Integer do |id_institute|
        @params = { institute: opts[:institutions].institute_id(id_institute)[0], flag: false }
        @params[:statistics] = @params[:institute].students_statistics_institute
        r.is { view('classes') }
        r.get 'reverse' do
          @params[:flag] = true
          view('classes')
        end
        r.on 'class', Integer do |id_class|
          obj_class = @params[:institute].class_id(id_class)[0]
          @params[:name_class] = obj_class.to_s
          @params[:id_class] = obj_class.id
          @params[:filter] = nil
          r.is do
            @params[:students] = obj_class.all_students
            view('class')
          end

          r.get Integer do |letter|
            @params[:students] = obj_class.filter_students(('А'..'Я').to_a[letter - 1])
            @params[:filter] = ('А'..'Я').to_a[letter - 1]
            view('class')
          end
        end
      end
    end

    r.on 'instituties' do
      r.get 'type', String do |type|
        @params = { institutions: opts[:institutions].filter_type(type),
                    filter: (case type
                             when 'school'
                               'Школа'
                             when 'lyceum'
                               'Лицей'
                             else
                               'Гимназия'
                             end) }
        view('institutions')
      end
    end
  end
end
