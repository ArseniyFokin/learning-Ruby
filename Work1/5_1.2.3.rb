def input_num()
    text = gets
    if text.nil?
        abort "Вы вышли из программы"
    end
    text = text.strip
    if text.to_i.to_s != text and text.to_f.to_s != text
        abort "Вы ввели не число"
    end
    num = text.to_f
    return num
end


def user_input()
    puts "Первая сторона треугольника"
    print ">>>"
    a = input_num()
    puts "Вторая сторона треугольника"
    print ">>>"
    b = input_num()
    puts "Третья сторона треугольника"
    print ">>>"
    c = input_num()
    puts "Радиус окружности"
    print ">>>"
    r = input_num()
    return a, b, c, r
end


def user_output(check)
    if check
        puts "Треугольник можно разместить в окружность"
    else
        puts "Треугольник нельзя разместить в окружность"
    end
end


def area_triangle(a, b, c)
    p = (a + b + c) * 0.5
    return Math.sqrt(p * (p - a) * (p - b) * (p - c))
end


def radius_circumscribed_circle(a, b, c)
    return (a * b * c) / (4 * area_triangle(a, b, c))
end


def check_triangle_in_circle(a, b, c, r)
    if radius_circumscribed_circle(a, b, c) <= r + 1e-9
        return true
    end
    return false
end


def main()
    puts "\x1b[1;31mВписанный треугольник\x1b[37m"
    puts "Считывает длины трёх сторон треугольника и определяет, можно ли разместить этот треугольник в круге радиуса r"
    user_output(check_triangle_in_circle(*user_input()))
end


main()
