class Student
  include Comparable

  attr_reader :surname, :name, :patronymic, :date_of_birth, :sex, :class_number, :institute

  def initialize(student)
    @surname = student[:surname]
    @name = student[:name]
    @patronymic = student[:patronymic]
    @date_of_birth = student[:date_of_birth]
    @sex = student[:sex]
  end
end