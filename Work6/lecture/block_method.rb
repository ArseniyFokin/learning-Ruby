class Thing
  def square(n)
    n*n
  end
end

thing = Thing.new
square_method = thing.method(:square)
pp square_method.call(9)
pp [1, 2, 3].map(&square_method)
