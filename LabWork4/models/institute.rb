# frozen_string_literal: true

require 'csv'

require_relative 'institute_class'

class Institute
  attr_reader :type, :number

  def initialize(name)
    @classes = Hash.new{|hash, key| hash[key] = InstituteClass.new(key)}
    name = name.split(' №')
    @type = name[0]
    @number = name[1].to_i
  end

  def add_student_in_class(institute_class, student)
    @classes[institute_class].add_student(student)
  end
  
  def <=> (other)
    [@type, @number] <=> [other.type, other.number]
  end

  def to_s
    "#{@type} №#{@number}"
  end
end