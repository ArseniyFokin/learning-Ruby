require_relative "str_to_num"


def main
    if !ARGV.size or (ARGV.size == 1 and ARGV[0] == '--help')
        print "Приложение эмитирует игру на рынке. Передайте стартовый капитал и количество дней в качестве аргументов приложения.\n\n"
        print "2_market_game.rb CAPITAL DAYS\n\n"
        print "CAPITAL - real number, >= 0"
        print "DAYS - integer, >= 0"
    elsif ARGV.size == 2
        capital = str_to_float(ARGV[0])
        days = str_to_int(ARGV[1])
        if capital.nil? or days.nil? or capital < 0 or days < 0
            abort "Переданы неправильные аргументы, обратитесь к справке (--help)"
        end
        for i in 1..days
            magic_num = rand(15)
            case magic_num
            when 15
                capital += 0.1 * capital
            when 13, 14
                capital += 0.02 * capital
            when 10..12
                capital = capital
            when 8, 9
                capital -= 0.02 * capital
            when 6, 7
                capital -= 0.1 * capital
            else
                capital -= 0.5 * capital
            end
            puts "Текущее состояние счёта: " + capital.to_s
        end
        puts "Состояние счёта после " + days.to_s + " дней: " + capital.to_s
    else
        abort "Переданы неправильные аргументы, обратитесь к справке (--help)"
    end
end


main if __FILE__ == $PROGRAM_NAME