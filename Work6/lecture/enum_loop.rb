numbers = Enumerator.new do |yielder|
  number = 0
  count = 1
  loop do
    number += count
    count += 1
    yielder.yield number
  end
end.lazy

pp numbers.first(10)
pp numbers.select{|num| num.even?}.first(10)