# frozen_string_literal: true

# A module containing a textual presentation of the menu
module TextMenu
  def self.text_start
    [
      { name: 'All contacts', value: 'all_contacts' },
      { name: 'View contact', value: 'view_one_contact' },
      { name: 'Add contact', value: 'add_person' },
      { name: 'Remove contact', value: 'del_person' },
      { name: 'Change address/phone/status', value: 'change_data' },
      { name: 'List all birthdays, grouped by month', value: 'birthdays_group' },
      { name: 'Create invitations', value: 'invitations' },
      { name: 'Statistics', value: 'statistics' },
      { name: 'Exit', value: 'close' }
    ]
  end

  def self.text_select_add_del_person
    [
      { name: 'Add contact', value: 'add_person' },
      { name: 'Del contact', value: 'del_person' }
    ]
  end

  def self.text_select_person(notebook)
    choise = []
    notebook.list_person.each do |p|
      full_name = "#{p.name} #{p.surname}"
      full_name += " #{p.patronymic}" if !p.patronymic.nil?
      choise.push({ name: full_name, value: p })
    end
    choise
  end

  def self.text_change_data
    [
      { name: 'Change address', value: 'address' },
      { name: 'Change mobile_phone', value: 'mobile' },
      { name: 'Change home_phone', value: 'home_phone' },
      { name: 'Change status', value: 'status' }
    ]
  end

  def self.text_select_optional_fields(fields)
    [
      { name: "Yes #{fields}", value: 1 },
      { name: "No #{fields}", value: nil }
    ]
  end
end
