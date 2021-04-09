# frozen_string_literal: true

require 'csv'

require_relative 'person'
require_relative 'statistics'

# The class describes the notebook
class Notebook

  def initialize
    @list_person = []
  end

  def notebook_load_from_file(path)
    csv = CSV.read(path, headers: true, col_sep: ';')
    csv.each do |c|
      add_person(c)
    end
  rescue StandardError
    puts 'Oops, file problem'
  end

  def add_person(hash_person)
    @list_person.push(Person.new(hash_person))
  end

  def change_mobile(index, mobile)
    @list_person[index].mobile = mobile
  end

  def change_home_phone(index, home_phone)
    @list_person[index].home_phone = home_phone
  end

  def change_adress(index, adress)
    @list_person[index].adress = adress
  end

  def all_birthdays_grouped_by_month
    group = Hash.new { |h, k| h[k] = [] }
    @list_person.each do |p|
      group[p.date_birthday.mon] << p
    end
    group
  end

  def str_month(index)
    months = %w[January February March April May June
                July August September October November December]
    months[index - 1]
  end

  def print_birthdays_group
    group = all_birthdays_grouped_by_month
    group.keys.sort.each do |month|
      puts "#{str_month(month)}:"
      group[month].sort_by { |p| p.date_birthday.mday }.each do |person|
        puts "   #{person.date_birthday.mday} - #{person.surname} #{person.name}"
      end
    end
  end

  def statuses
    @list_person.collect(&:status).uniq
  end

  def person_as_status(status)
    @list_person.select do |person|
      person.status == status
    end
  end

  def create_folder(folder_name)
    path = File.expand_path("../data/#{folder_name}", __dir__)
    Dir.mkdir(path) if !File.exist?(path)
    path
  end

  def files_creation_by_status(folder_name, persons, event)
    path_folder = create_folder(folder_name)
    persons.each  do |p|
      path_file = File.expand_path(p.surname + event, path_folder)
      file_out = File.open(path_file, 'w')
      file_out.write("Hi #{p.name} #{p.surname}, let's go to the #{event}")
      file_out.close
    end
  end

  def statistics
    Statistics.new(@list_person).print_statistics
  end

  def print_all_person
    @list_person.each do |c|
      puts "#{c.name} #{c.surname} #{c.patronymic} #{c.mobile}"
    end
  end

  def del_person(person)
    @list_person.delete(person)
  end

  def choice_person
    choise = []
    @list_person.each do |p|
      full_name = "#{p.name} #{p.surname}"
      full_name += " #{p.patronymic}" if !p.patronymic.nil?
      choise.push({ name: full_name, value: p })
    end
    choise
  end
end
