# frozen_string_literal: true

require_relative '../lib/task'

# Task list class
class Tasks
  attr_reader :list

  def initialize
    @list_task = []
  end

  def check_task(str)
    list_a = %w[отдал отдала потерял потеряла подарил подарила
                передал передала съел съела]
    list_a.each do |a|
      return 'add' if str.include? a
    end
    'sub'
  end

  def add_task(str)
    num1, num2 = str.scan(/\d+/).map(&:to_i)
    c_t = check_task(str)
    ans = if c_t == 'add'
            num1 + num2
          else
            num1 - num2
          end
    @list_task.append(Task.new(num1, num2, ans)) if (num1 >= 0) && (num2 >= 0) && (ans >= 0)
  end

  def load_from_file(_path)
    file = File.new(File.expand_path('../data/tasks.txt', __dir__), 'r')
    file.each do |s|
      add_task(s)
    end
  end

  def ease_tasks
    count = 0
    @list_task.each do |t|
      if (t.num1 > 20) || (t.num2 > 20) || (t.ans > 20)
        @list_task.delete(t)
        count += 1
      end
    end
    count
  end

  def count_complexity_task
    count1 = 0
    count2 = 0
    count3 = 0
    @list_task.each do |t|
      c = t.complexity
      case c
      when 1
        count1 += 1
      when 2
        count2 += 1
      else
        count3 += 1
      end
    end
    [count1, count2, count3]
  end
end
