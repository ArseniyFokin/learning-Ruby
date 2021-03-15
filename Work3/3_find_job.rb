require_relative "str_to_num"


def main
    varg = {"--name" => false, 
            "--surname" => false, 
            "--mail" => false, 
            "--age" => false, 
            "--experience" => false}
    if ARGV.size == 0 or (ARGV.size == 1 and ARGV[0] == '--help')
        print "Приложение подбирает работу для вас на основании введённых данных.\n\n"
        print "3_find_job.rb --name=NAME --surname=SURNAME --mail=MAIL --age=AGE --experience=EXPERIENCE\n\n"
    elsif ARGV.size == 5
        profession = []
        for a in ARGV
            arg = a.split('=')
            if varg.key? arg[0] and varg[arg[0]] == false
                if ((arg[0] == "--name" or arg[0] == "--surname" or arg[0] == "--mail") and arg[1])
                    varg[arg[0]] = arg[1]
                elsif !((num = str_to_int(arg[1])).nil?) and
                      ((arg[0] == "--age" and num < 100 and num > 15) or
                      (arg[0] == "--experience" and num >= 0))
                    varg[arg[0]] = num
                else
                    abort "Переданы неправильные аргументы, обратитесь к справке (--help)"
                end
            else
                abort "Переданы неправильные аргументы, обратитесь к справке (--help)"
            end
        end
        if varg['--name'] == "Пётр" and varg['--surname'] == "Петрович"
            profession.append("Руководитель")
        end
        if varg['--mail'].include? "code"
            profession.append("Инженер")
        end
        if varg['--experience'] < 2
            profession.append("Стажёр")
        end
        if varg['--age'] >= 45 and varg['--age'] <= 60
            profession.append("Бывалый")
        end
        puts "Должности, которые может занять кандидат:"
        for p in profession
            if varg['--experience'] > 15
                p = "Заслуженный " + p
            end
            if varg['--experience'] > 5
                p = "Известный " + p
            end
            puts p
        end
        if !profession.size
            puts "-"
        end
    else
        abort "Переданы неправильные аргументы, обратитесь к справке (--help)"
    end
end


main if __FILE__ == $PROGRAM_NAME