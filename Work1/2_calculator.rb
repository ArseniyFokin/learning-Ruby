if RUBY_PLATFORM.include?('mingw32')
    Encoding.default_external = Encoding::CP866
end
 
puts "\x1b[1;31mПростейший калькулятор\x1b[37m"
puts "Считывает вещественные числа и складывает их с предыдущими введёнными числами"

ans = 0

while true
    print ">>>"
    text = gets
    if text.nil? or text.chomp == 'over'
        puts "Результат сложения чисел: " + ans.to_s
        break
    end
    num = text.to_f
    ans += num
    puts "Считанное число: " + num.to_s
    puts "Значение суммы на настоящий момент: " + ans.to_s
end    