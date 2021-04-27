module Debug
  # def self.hello
  #   puts "hello"
  # end

  def who_am_i?
    "#{self.class.name} (id #{self.object_id})"
  end
end

class Test
  include Debug
end

class Abc
  include Debug
end

test = Test.new
pp test.who_am_i?
# test.hello

abc = Abc.new
pp abc.who_am_i?

