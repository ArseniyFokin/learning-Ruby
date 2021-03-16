require_relative "student"
require "csv"

def read_csv(path)
    students = []
    CSV.foreach(path) do |row|
        students.push(Student.new(*row))
    end
    return students
end

def main
    puts "Приложение для работы с базой студентов"
    puts "Выберите действие, написав число от 1 до 3:"
    puts "1 - Сформировать общий список в файл."
    puts "2 - Сформировать список классов для школы."
    puts "3 - Завершить работу."
    act = gets.to_i
    if act == 1
        students = read_csv("students.csv")
        students = students.sort_by{|s| [s.educational_institution[1].to_i, s.class_number, s.date_of_birth]}
        
    elsif act == 2
        students = read_csv("students.csv")
    else
        puts "Спасибо за использование программы"
    end
end


if __FILE__ == $0
    main
end