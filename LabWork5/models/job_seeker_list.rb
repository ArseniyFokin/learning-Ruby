# frozen_string_literal: true

require 'csv'

require_relative 'job_seeker'

# Class describing the list of vacancies
class JobSeekerList
  def initialize(job_seekers = [])
    @job_seekers = job_seekers.map do |job_seeker|
      [job_seeker.id, job_seeker]
    end.to_h
  end

  def read_csv(path)
    csv = CSV.read(path, headers: true, col_sep: ';', header_converters: :symbol)
    csv.each do |job_seeker|
      add_job_seeker(job_seeker)
    end
  end

  def all_job_sekeers
    @job_seekers.values
  end

  def job_seeker_by_id(id)
    @job_seekers[id]
  end

  def add_job_seeker(parameters)
    job_seeker_id = (@job_seekers.keys.max or 0) + 1
    @job_seekers[job_seeker_id] = JobSeeker.new(job_seeker_id, parameters)
    job_seeker_id
  end

  def delete_job_seeker(job_seeker_id)
    @job_seekers.delete(job_seeker_id)
  end

  def update_job_seeker(job_seeker_id, parameters)
    @job_seekers[job_seeker_id].update(parameters)
  end

  def count_job_seekers
    @job_seekers.size
  end

  def average_desired_salary_by_age(age)
    count = 0
    salary = 0
    @job_seekers.each_value do |job_seeker|
      if job_seeker.age == age
        count += 1
        salary += job_seeker.desired_salary
      end
    end
    salary.to_f / count
  end
end
