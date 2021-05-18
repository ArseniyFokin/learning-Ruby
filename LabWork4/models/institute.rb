# frozen_string_literal: true

require 'csv'

require_relative 'institute_class'

# Class describing the institution
class Institute
  attr_reader :type, :number, :id, :all_count, :female_count, :male_count

  def initialize(name, id)
    @classes = Hash.new { |hash, key| hash[key] = InstituteClass.new(key, @classes.size + 1) }
    name = name.split(' №')
    @type = name[0]
    @number = name[1].to_i
    @id = id.to_i
  end

  def add_student_in_class(institute_class, student)
    @classes[institute_class].add_student(student)
  end

  def <=>(other)
    [@type, @number] <=> [other.type, other.number]
  end

  def to_s
    "#{@type} №#{@number}"
  end

  def to_link
    case @type
    when 'Школа'
      "school/#{@number}"
    when 'Лицей'
      "lyceum/#{@number}"
    else
      "gymnasium/#{@number}"
    end
  end

  def all_classes(flag)
    if flag
      @classes.values.sort.reverse
    else
      @classes.values.sort
    end
  end

  def class_id(id)
    @classes.values.select do |obj_class|
      obj_class if obj_class.id == id
    end
  end

  def students_statistics_institute
    statistics = { male: 0, female: 0, all: 0 }
    @classes.each_value do |obj_class|
      statistics_class = obj_class.students_statistics_class
      statistics[:male] += statistics_class[:male]
      statistics[:female] += statistics_class[:female]
      statistics[:all] += statistics_class[:all]
    end
    statistics
  end
end
