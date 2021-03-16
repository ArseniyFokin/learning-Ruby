# frozen_string_literal: true

require "csv"

class Student
    attr_reader :surname
    attr_reader :name
    attr_reader :middle_name
    attr_reader :date_of_birth
    attr_reader :sex
    attr_reader :class_number
    attr_reader :educational_institution

    def initialize(surname, name, middle_name, date_of_birth, sex, class_number, educational_institution)
        @surname = surname
        @name = name
        @middle_name = middle_name
        @date_of_birth = Date.strptime(date_of_birth, '%Y-%m-%d')
        @sex = sex
        @class_number = class_number.to_i
        @educational_institution = educational_institution.split(" №")
    end

end