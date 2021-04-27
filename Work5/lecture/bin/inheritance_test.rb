# Sample parent class
class Parent
  def hello
    puts "Hello, world! From #{self}"
  end
end

# Sample child class
class Child < Parent

end

parent = Parent.new
parent.hello

child = Child.new
child.hello

pp child.class
pp child.class.superclass.superclass