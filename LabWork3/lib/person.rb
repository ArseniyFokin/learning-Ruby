# frozen_string_literal: true

# Class that contains information about each entry in a notebook
class Person
  attr_accessor :mobile, :home_phone, :address, :status
  attr_reader :name, :surname, :patronymic, :date_birthday, :sex

  def initialize(characteristic)
    @name = characteristic['name']
    @surname = characteristic['surname']
    @patronymic = characteristic['patronymic']
    @mobile = characteristic['mobile']
    @home_phone = characteristic['home_phone']
    @address = characteristic['address']
    @date_birthday = Date.strptime(characteristic['date_birthday'], '%Y-%m-%d')
    @sex = characteristic['sex']
    @status = characteristic['status']
  end

  def month_birthday
    @date_birthday.mon
  end

  def age
    now = Date.today
    age = now.year - @date_birthday.year
    if (now.mon < month_birthday) ||
       ((now.mon == month_birthday) && (now.mday < @date_birthday.mday))
      age -= 1
    end
    age
  end

  def to_s
    puts "Name: #{@name},\n" \
         "Surname: #{@surname},\n" \
         "Patronymic: #{@patronymic.nil? ? '-' : @patronymic},\n" \
         "Mobile: #{@mobile},\n" \
         "Home phone: #{@home_phone.nil? ? '-' : @home_phone},\n" \
         "Address: #{@address.nil? ? '-' : @address},\n" \
         "Date birthday: #{@date_birthday},\n" \
         "Sex: #{@sex},\n" \
         "Status: #{@status}\n"
  end
end
