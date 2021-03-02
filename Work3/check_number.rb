require_relative "str_to_num"


def main
    if ARGV.size == 0 or (ARGV.size == 1 and ARGV[0] == '--help')
        print "Данное приложение производит проверку числа. Передайте число в качестве первого аргумента приложения.\n\n"
        print "check_number.rb NUMBER\n\n"
    elsif ARGV.size == 1 and !((num = str_to_float(ARGV[0])).nil?)
        if num > 0
            puts "Положительное число"
        elsif num < 0
            puts "Не положительное, а отрицательное число"
        else
            puts "Непонятное число"
        end
    else
        puts "Переданы неправильные аргументы, обратитесь к справке (--help)"
    end
end


main if __FILE__ == $PROGRAM_NAME