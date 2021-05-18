# frozen_string_literal: true

# Class describing the class at the institute
class InstituteClass
  attr_reader :number, :letter, :id

  def initialize(name, id)
    @number = name[0...-1].to_i
    @letter = name[-1]
    @students = []
    @id = id
  end

  def add_student(student)
    @students.push(student)
  end

  def <=>(other)
    [@number, @letter] <=> [other.number, other.letter]
  end

  def to_s
    "#{@number}#{letter}"
  end

  def all_students
    @students.sort.map(&:to_s)
  end

  def filter_students(letter)
    @students.sort.select do |student|
      student if student.surname[0] == letter
    end
  end

  def students_statistics_class
    statistics = { male: 0, female: 0, all: @students.size }
    @students.each do |student|
      if student.sex == 'мужской'
        statistics[:male] += 1
      else
        statistics[:female] += 1
      end
    end
    statistics
  end
end
