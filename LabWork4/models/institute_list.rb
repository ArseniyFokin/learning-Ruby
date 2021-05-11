# frozen_string_literal: true

require 'csv'

require_relative 'student'
require_relative 'institute'

class InstituteList

  def initialize
    @institutions = Hash.new{|hash, key| hash[key] = Institute.new(key)}
  end

  def read_csv(path)
    csv = CSV.read(path, col_sep: ',')
    csv.each do |row|
      student = Student.new({
        surname: row[0],
        name: row[1],
        patronymic: row[2],
        date_of_birth: row[3],
        sex: row[4],
      })
      @institutions[row[6]].add_student_in_class(row[5], student)
    end
  end

  def all_institute
    @institutions.values.sort.map(&:to_s)
  end
end
