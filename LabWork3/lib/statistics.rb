# frozen_string_literal: true

# Class describing the statistics of a notebook
class Statistics
  attr_reader :stats

  def initialize(notebook)
    @stats = {}
    @stats['Total contacts'] = notebook.size
    sex_statistic(notebook)
    age_statistic(notebook)
    status_statistics(notebook)
    @stats['Contacts with home number'] = notebook.count do |p|
      !p.home_phone.nil?
    end
    @stats['Contacts with address'] = notebook.count do |p|
      !p.address.nil?
    end
  end

  def sex_statistic(notebook)
    @stats['Number of male contacts'] = notebook.count do |person|
      person.sex == 'man'
    end
    @stats['Number of woman contacts'] = notebook.count do |person|
      person.sex == 'woman'
    end
  end

  def change_stat_age(age)
    if age < 20
      @stats['age < 20'] += 1
    elsif (age >= 20) && (age < 30)
      @stats['20 <= age < 30'] += 1
    elsif (age >= 30) && (age < 40)
      @stats['30 <= age < 40'] += 1
    else
      @stats['age > 40'] += 1
    end
  end

  def age_statistic(notebook)
    @stats['age < 20'] = 0
    @stats['20 <= age < 30'] = 0
    @stats['30 <= age < 40'] = 0
    @stats['age > 40'] = 0
    notebook.each do |p|
      age = p.age
      change_stat_age(age)
    end
  end

  def status_statistics(notebook)
    notebook.each do |p|
      if @stats.key?(p.status)
        @stats[p.status] += 1
      else
        @stats[p.status] = 1
      end
    end
  end

  def print_statistics
    puts 'STATISTICS:'
    @stats.each_key do |s|
      puts "#{s}: #{stats[s]}"
    end
  end
end
