# frozen_string_literal: true

require 'tty-prompt'

require_relative 'statistics'
require_relative 'text_menu'
require_relative 'person'

# Class describing user interaction
class Menu
  attr_reader :prompt, :notebook

  def initialize(notebook)
    puts 'NOTEBOOK'
    @prompt = TTY::Prompt.new
    @notebook = notebook
  end

  def start
    loop do
      choice = @prompt.select('Select action?', TextMenu.text_start)
      return if choice == 'close'

      method(choice).call
    end
  end

  def optional_stat(stat)
    availability = @prompt.select(stat, TextMenu.text_select_optional_fields(stat))
    if availability.nil?
      nil
    else
      @prompt.ask("#{stat}: ")
    end
  end

  def all_contacts
    @notebook.list_person.each do |c|
      puts "#{c.name} #{c.surname} #{c.patronymic} #{c.mobile}"
    end
  end

  def view_one_contact
    person = @prompt.select('Select contact?', TextMenu.text_select_person(@notebook))
    person.to_s
  end

  def add_person
    stats = {}
    stats['name'] = @prompt.ask('Name: ')
    stats['surname'] = @prompt.ask('Surname: ')
    stats['patronymic'] = optional_stat('Patronymic')
    stats['mobile'] = @prompt.ask('Mobile: ')
    stats['home_phone'] = optional_stat('Home phone')
    stats['address'] = optional_stat('Address')
    stats['date_birthday'] = @prompt.ask('Date_birthday (Y/M/D): ', convert: :date).to_s
    stats['sex'] = @prompt.select('Sex (man/woman): ', %w[man woman])
    stats['status'] = @prompt.ask('Status: ')
    @notebook.add_person(stats)
  end

  def del_person
    person = @prompt.select('Select action?', TextMenu.text_select_person(@notebook))
    @notebook.list_person.delete(person)
  end

  def change_data
    person = @prompt.select('Select action?', TextMenu.text_select_person(@notebook))
    data = @prompt.select('Select action?', TextMenu.text_change_data)
    ans = @prompt.ask("#{data}: ")
    person.address = ans if data == 'address'
    person.mobile = ans if data == 'mobile'
    person.home_phone = ans if data == 'home_phone'
    person.status = ans if data == 'status'
  end

  def birthdays_group
    @notebook.print_birthdays_group
  end

  def invitations
    status = @prompt.select('Select action?', @notebook.statuses)
    event = @prompt.ask('Event name: ')
    @notebook.files_creation_by_status("#{event}_#{status}",
                                       @notebook.person_as_status(status), event)
  end

  def statistics
    Statistics.new(@notebook.list_person).print_statistics
  end
end
