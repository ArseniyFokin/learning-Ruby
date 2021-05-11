class InstituteClass
  def initialize(name)
    @name = name
    @students = Array.new
  end

  def add_student(student)
    @students.push(student)
  end
end