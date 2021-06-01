# frozen_string_literal: true

require_relative 'education_type'

# Class describing vacancies
class Vacancy
  attr_reader :id, :company, :title, :department, :salary, :age_interval, :education, :count_vacancy

  def initialize(id, parameters)
    @id = id
    update(parameters)
  end

  def update(parameters)
    @company = parameters[:company]
    @title = parameters[:title]
    @department = parameters[:department]
    @salary = parameters[:salary].to_i
    @age_interval = Range.new(*parameters[:age_interval].split('-').map(&:to_i))
    @education = parameters[:education]
    @count_vacancy = parameters[:count_vacancy].to_i
  end

  def to_h
    {
      id: @id,
      company: @company,
      title: @title,
      department: @department,
      salary: @salary,
      age_interval: @age_interval.to_s.gsub('..', '-'),
      education: @education,
      count_vacancy: @count_vacancy
    }
  end

  def age_include?(age)
    @age_interval.include?(age)
  end

  def almost_age_include?(age)
    @age_interval.include?(age) or age == (@age_interval.min - 1) or age == (@age_interval.max + 1)
  end

  def check(job_seeker)
    !job_seeker.unwanted_company?(@company) and age_include?(job_seeker.age) and \
      EducationType.compare(@education,
                            job_seeker.education) and job_seeker.desired_salary <= @salary
  end

  def almost_check(job_seeker)
    !job_seeker.unwanted_company?(@company) and almost_age_include?(job_seeker.age) and \
      EducationType.compare(@education,
                            job_seeker.education) and job_seeker.desired_salary <= (@salary * 1.1)
  end

  def to_file(path)
    file_out = File.open(path, 'a+')
    file_out.write(to_s_for_file)
    file_out.close
  end

  def to_s_for_file
    "___#{@title}___\n" \
      "Компания: #{@company}\n" \
      "Отдел: #{@department}\n" \
      "Оклад: #{@salary}\n"
  end

  def reduce_the_count
    @count_vacancy -= 1
  end
end
