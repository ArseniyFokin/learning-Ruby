# frozen_string_literal: true

# Class describing one worker
class Worker
  attr_reader :name, :surname

  def initialize(worker)
    @name = worker['name']
    @surname = worker['surname']
    @patromymic = worker['patronymic']
    @email = worker['email']
    @avatar = worker['avatar']
  end

  def get_binding
    binding
  end
end
