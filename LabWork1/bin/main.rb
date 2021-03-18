# frozen_string_literal: true

require_relative '../lib/city'

def act1
  city = City.new
  city.load_from_csv(File.expand_path('../data/students.csv', __dir__))
  sort_city = city.sort_by_school_class_date
  sort_city.upload_to_csv(File.expand_path('../data/school.csv', __dir__))
end

def act2
  nil
end

def main
  puts 'Приложение для работы с базой студентов'
  puts 'Выберите действие, написав число от 1 до 3:'
  puts '1 - Сформировать общий список в файл.'
  puts '2 - Сформировать список классов для школы.'
  puts '3 - Завершить работу.'
  act = gets.to_i
  case act
  when 1
    act1
  when 2
    act2
  else
    puts 'Спасибо за использование программы'
  end
end

main if __FILE__ == $PROGRAM_NAME
