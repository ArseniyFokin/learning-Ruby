reach = Proc.new do |param|
  puts "You called proc with param #{param}"
end

reach.call(42)
reach.call('Nightmare')

proc_one = Proc.new do |param1, param2|
  puts "You called proc with param #{param1}"
end

proc_one.call('Some')