# frozen_string_literal: true

require 'csv'
require 'set'

require_relative 'vacancy'

# Class describing the list of vacancies
class VacancyList
  def initialize(vacancies = [])
    @vacancies = vacancies.map do |vacancy|
      [vacancy.id, vacancy]
    end.to_h
  end

  def read_csv(path)
    csv = CSV.read(path, headers: true, col_sep: ';', header_converters: :symbol)
    csv.each do |vacancy|
      add_vacancy(vacancy)
    end
  end

  def all_vacancies
    @vacancies.values
  end

  def filter_vacansies(title)
    return all_vacancies if title == ''

    @vacancies.values.filter { |vacancy| vacancy.title.include?(title) }
  end

  def vacancy_by_id(id)
    @vacancies[id]
  end

  def add_vacancy(parameters)
    vacancy_id = (@vacancies.keys.max or 0) + 1
    @vacancies[vacancy_id] = Vacancy.new(vacancy_id, parameters)
    vacancy_id
  end

  def update_vacancy(vacancy_id, parameters)
    @vacancies[vacancy_id].update(parameters)
  end

  def delete_vacancy(vacancy_id)
    @vacancies.delete(vacancy_id)
  end

  def count_vacancy
    @vacancies.size
  end

  def all_positions
    @vacancies.values.collect(&:title).uniq
  end

  def fill_statistics(statistics, title)
    @vacancies.each_value do |vacancy|
      next unless vacancy.title.eql? title

      statistics[:count] += 1
      statistics[:salary] += vacancy.salary
      statistics[:count_uniq_company].add(vacancy.company)
      statistics[:education].add(vacancy.education)
    end
  end

  def position_statistics(title)
    statistics = { title: title,
                   count: 0,
                   salary: 0,
                   count_uniq_company: Set.new,
                   education: Set.new }
    fill_statistics(statistics, title)
    statistics[:count_uniq_company] = statistics[:count_uniq_company].length
    statistics[:salary] /= statistics[:count]
    statistics
  end

  def average_possible_salary_by_age(age)
    count = 0
    salary = 0
    @vacancies.each_value do |vacancy|
      if vacancy.age_include?(age)
        count += 1
        salary += vacancy.salary
      end
    end
    salary.to_f / count
  end

  def search_job(job_seeker)
    @vacancies.values.filter { |vacancy| vacancy.check(job_seeker) }
  end

  def almost_search_job(job_seeker)
    @vacancies.values.filter { |vacancy| vacancy.almost_check(job_seeker) }
  end

  def reduce_the_amount(vacancy_id)
    vacancy = vacancy_by_id(vacancy_id)
    if vacancy.count_vacancy == 1
      delete_vacancy(vacancy_id)
    else
      vacancy.reduce_the_count
    end
  end
end
