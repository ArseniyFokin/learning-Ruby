lam_one = lambda do |param1, param2|
  puts "You call with '#{param1}'"
end

lam_one.call('Some', 'one')


lam_two = -> (param1, param2) do
  puts "You call with '#{param1}'"
end

lam_two.call('Info', 'wars')
