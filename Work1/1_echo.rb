if RUBY_PLATFORM.include?('mingw32')
    Encoding.default_external = Encoding::CP866
end

puts "\x1b[1;31mПриложение-повторятель\x1b[37m"
puts "Повторяет предложения, введённые пользователем."

while true
    print ">>>"
    text = gets
    if text.nil? or text.chomp == "stop, please!"
        break
    end
    puts text
end
