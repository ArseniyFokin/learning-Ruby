require 'csv'

class Class_in_school
  attr_accessor :students

  def initialize(students)
    @students = students
  end

  def upload_to_csv(path)
    csv = CSV.open(path, 'w')
    @students.each do |s|
      csv << s
    end
    csv.close()
  end

end