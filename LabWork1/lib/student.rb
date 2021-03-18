# frozen_string_literal: true

# Class describing the student
class Student
  attr_reader :surname, :name, :middle_name, :date_of_birth, :sex, :class_number,
              :educational_institution

  def initialize(arr)
    surname, name, middle_name, date_of_birth, sex, class_number, educational_institution = *arr
    @surname = surname
    @name = name
    @middle_name = middle_name
    @date_of_birth = Date.strptime(date_of_birth, '%Y-%m-%d')
    @sex = sex
    @class_number = [class_number.slice(0...-1), class_number[-1]]
    @educational_institution = educational_institution.split(' №')
  end
end
