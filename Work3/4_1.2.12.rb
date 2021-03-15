require_relative "str_to_num"

def main
    if ARGV.size == 0 or (ARGV.size == 1 and ARGV[0] == '--help')
        print "Приложение ищет max{min(a, b), min(c, d)}.\n\n"
        print "4_1.2.12.rb a b c d\n\n"
    elsif ARGV.size == 4 and !((a = str_to_float(ARGV[0])).nil?) and
                            !((b = str_to_float(ARGV[1])).nil?) and
                            !((c = str_to_float(ARGV[2])).nil?) and
                            !((d = str_to_float(ARGV[3])).nil?)
        if a <= b
            min_a_b = a
        else
            min_a_b = b
        end

        unless c > d
            min_c_d = c
        else
            min_c_d = d
        end

        case min_a_b >= min_c_d
        when true
            max_min_a_b_min_c_d = min_a_b
        else
            max_min_a_b_min_c_d = min_c_d
        end

        puts max_min_a_b_min_c_d = min_c_d
    else
        abort "Переданы неправильные аргументы, обратитесь к справке (--help)"
    end
  end
  
  # Keep it in the bottom of the file
  if __FILE__ == $0
      main
  end