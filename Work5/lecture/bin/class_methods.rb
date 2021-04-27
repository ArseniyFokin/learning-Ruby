class Some
  def hello
    puts 'hello'
  end

  def self.make_some
    Some.new
  end
end

some = Some.new
some.hello
# Error some.make_some
pp Some.make_some