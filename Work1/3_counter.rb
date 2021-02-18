if RUBY_PLATFORM.include?('mingw32')
    Encoding.default_external = Encoding::CP866
end

puts "\x1b[1;31mПроверка корректного ввода\x1b[37m"
puts "Контролирует, что было введено целое положительное число"

success = 0
error = 0

while true
    print ">>>"
    text = gets
    if text.nil? or text.strip == "99.999"
        puts "Колличество успешных вводов: " + success.to_s
        puts "Колличество ошибочных вводов: " + error.to_s
        break
    end
    num = text.to_i

    if num.to_s != text.strip
        puts "Введённая строка содержит лишние символы"
        error += 1
    elsif num > 0
        puts "Правильный ввод"
        puts "Введённое число: " + num.to_s
        success += 1
    else
        puts "Неправильный ввод"
        error += 1
    end
end
