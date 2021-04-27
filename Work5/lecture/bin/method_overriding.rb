# Sample parent class
class Parent
  def hello
    puts "Hello, world! From #{self}"
  end

  def to_s
    'Parent'
  end
end

# Sample child class
class Child < Parent
  def hello
    super # Calling hello from the parent class
    puts "Hello, world! From the Child"
  end

  def to_s
    'Child'
  end
end

# This class has broken implementation of the hello
class BrokenChild < Parent
  # no arguments
  def hello(name)
    puts "Hello. #{name}"
  end
end

parent = Parent.new
child = Child.new

parent.hello
child.hello

puts parent
puts child

# @param object [Parent] the object to call method on
def call_hello(object)
  object.hello
end

broken_child = BrokenChild.new
broken_child.hello("ABCs")

call_hello(parent)
call_hello(child)
# call_hello(broken_child)
