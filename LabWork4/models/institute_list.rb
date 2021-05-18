# frozen_string_literal: true

require 'csv'

require_relative 'student'
require_relative 'institute'

# Class describing the list of institutions
class InstituteList
  def initialize
    @institutions = Hash.new { |hash, key| hash[key] = Institute.new(key, @institutions.size + 1) }
  end

  def read_csv(path)
    csv = CSV.read(path, col_sep: ',')
    csv.each do |row|
      student = Student.new({
                              surname: row[0],
                              name: row[1],
                              patronymic: row[2],
                              date_of_birth: row[3],
                              sex: row[4]
                            })
      @institutions[row[6]].add_student_in_class(row[5], student)
    end
  end

  def all_institute
    @institutions.values.sort.map do |institute|
      { id: institute.id,
        type: institute.type,
        number: institute.number }
    end
  end

  def institute_id(id)
    @institutions.values.select do |institute|
      institute if institute.id == id
    end
  end

  def filter_type(type)
    type = case type
           when 'school'
             'Школа'
           when 'lyceum'
             'Лицей'
           else
             'Гимназия'
           end
    filter_institution = @institutions.values.sort.select do |institute|
      institute if institute.type == type
    end
    filter_institution.map do |institute|
      { id: institute.id, type: institute.type, number: institute.number }
    end
  end
end
