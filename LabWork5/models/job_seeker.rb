# frozen_string_literal: true

require 'date'

# Class describing job seeker
class JobSeeker
  attr_reader :id, :surname, :name, :patronymic, :date_of_birth,
              :education, :specialty, :desired_salary, :unwanted_companies

  def initialize(id, parameters)
    @id = id
    update(parameters)
    @date_of_birth = Date.parse(@date_of_birth.to_s)
    @desired_salary = @desired_salary.to_i
  end

  def update(parameters)
    @surname = parameters[:surname]
    @name = parameters[:name]
    @patronymic = parameters[:patronymic]
    @date_of_birth = parameters[:date_of_birth]
    @education = parameters[:education]
    @specialty = parameters[:specialty]
    @desired_salary = parameters[:desired_salary]
    @unwanted_companies = (parameters[:unwanted_companies] or '').split(/,\s*/)
  end

  def to_h
    {
      id: @id,
      surname: @surname,
      name: @name,
      patronymic: @patronymic,
      date_of_birth: @date_of_birth,
      education: @education,
      specialty: @specialty,
      desired_salary: @desired_salary,
      unwanted_companies: @unwanted_companies
    }
  end

  def age
    today = Date.today
    year = today.year - @date_of_birth.year
    if today.mon < @date_of_birth.mon ||
       ((today.mon == @date_of_birth.mon) && (today.mday < @date_of_birth.mday))
      year -= 1
    end
    year
  end

  def unwanted_company?(company)
    @unwanted_companies.include?(company)
  end
end
