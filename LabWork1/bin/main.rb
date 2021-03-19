# frozen_string_literal: true

require_relative '../lib/city'
require_relative '../lib/class_in_school'

def general_act
  city = City.new
  city.load_from_csv(File.expand_path('../data/students.csv', __dir__))
  city
end

def act1(city)
  sort_city = city.sort_by_school_class_date
  sort_city.upload_to_csv(File.expand_path('../data/school.csv', __dir__))
  puts "Успешное выполнение"
end

def act2(city)
  puts "Введите тип учебного заведения"
  view = gets
  puts "Введите номер"
  num = gets
  classes = city.select_school("Школа", "449")
  if !classes.empty?
    Dir.mkdir(File.expand_path(('../data/' + "School" + "_" + num).chomp, __dir__))
    d = Dir.new(File.expand_path(('../data/' + "School" + "_" + num).chomp, __dir__))
    for c in classes.keys
      class_in_sl = Class_in_school.new(classes[c])
      class_in_sl.upload_to_csv(File.join(d, c))
    end
    puts "Успешное выполнение"
  else
    puts "Выбранного учебного заведения не существует"
  end
end

def main
  puts 'Приложение для работы с базой студентов'
  puts 'Выберите действие, написав число от 1 до 3:'
  puts '1 - Сформировать общий список в файл.'
  puts '2 - Сформировать список классов для школы.'
  puts '3 - Завершить работу.'
  city = general_act
  loop do
    act = gets.to_i
    case act
    when 1
        act1(city)
    when 2
        act2(city)
    else
        puts 'Спасибо за использование программы'
        break
    end
  end
end

main if __FILE__ == $PROGRAM_NAME
