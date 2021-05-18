# frozen_string_literal: true

# Class describing the student
class Student
  include Comparable

  attr_reader :surname, :name, :patronymic, :date_of_birth, :sex

  def initialize(student)
    @surname = student[:surname]
    @name = student[:name]
    @patronymic = student[:patronymic]
    @date_of_birth = student[:date_of_birth]
    @sex = student[:sex]
  end

  def to_s
    "#{@surname} #{@name} #{@patronymic}"
  end

  def <=>(other)
    [@surname, @name, @patronymic] <=> [other.surname, other.name, other.patronymic]
  end
end
