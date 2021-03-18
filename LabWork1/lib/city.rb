# frozen_string_literal: true

require_relative '../lib/student'

require 'csv'

# Class containing students all over the city
class City
  attr_reader :students

  def initialize
    @students = []
  end

  def init_from_list(list)
    @students = list
  end

  def load_from_csv(path)
    CSV.foreach(path) do |row|
      @students.push(Student.new(row))
    end
  end

  def sort_by_school_class_date
    sort_city = City.new
    sort_city.init_from_list(@students.sort_by do |s|
      [s.educational_institution[1].to_i,
       s.class_number[0].to_i,
       s.date_of_birth]
    end)
    sort_city
  end

  def upload_to_csv(path)
    csv = CSV.open(path, 'w')
    @students.each do |s|
      csv << [s.surname,
              s.name,
              s.middle_name,
              s.date_of_birth,
              s.sex,
              s.class_number.join,
              s.educational_institution.join(' №')]
    end
  end
end