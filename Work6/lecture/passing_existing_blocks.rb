odd_filter = -> (value) do
  value.odd?
end

even_filter = -> (value) do
  value.even?
end

filter = even_filter

pp [1, 543, 32, 2, 45].select(&filter)
pp filter.call(11)