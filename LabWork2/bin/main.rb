# frozen_string_literal: true

require 'csv'
require 'tty-prompt'
require_relative '../lib/tasks'

def main
  tasks = Tasks.new
  tasks.load_from_file(File.expand_path('../data/tasks.txt', __dir__))
  puts "Колличество удалённых задач: #{tasks.ease_tasks}"
  count1, count2, count3 = *tasks.count_complexity_task
  puts "Количество задач сложности 1: #{count1}"
  puts "Количество задач сложности 2: #{count2}"
  puts "Количество задач сложности 3: #{count3}"
end

main if __FILE__ == $PROGRAM_NAME
