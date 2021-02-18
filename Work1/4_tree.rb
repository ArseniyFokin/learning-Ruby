if RUBY_PLATFORM.include?('mingw32')
    Encoding.default_external = Encoding::CP866
end

puts "\x1b[1;31mСчитывание русских строк\x1b[37m"
puts "Считывает введённые слова и подсчитывает сколько раз введено слово дерево"

count = 0

while true
    print ">>>"
    text = gets
    if text.nil? or text.strip.encode('UTF-8') == "конец"
        puts "Количество введённых слов 'дерево': " + count.to_s
        break
    end

    text = text.strip.encode('UTF-8')
    
    if text == "дерево"
        count += 1
    end
end    
