# frozen_string_literal: true

require_relative "my_complex"


def main
    complex_num1 = MyComplex.new(9, 6)
    complex_num2 = MyComplex.new(3, 4)

    complex_num_add = complex_num1.add(complex_num2)
    puts complex_num_add

    complex_num_sub = complex_num1.sub(complex_num2)
    puts complex_num_sub

    complex_num_multiply = complex_num1.multiply(complex_num2)
    puts complex_num_multiply

    complex_num_divide = complex_num1.divide(complex_num2)
    puts complex_num_divide
end


main if __FILE__ == $PROGRAM_NAME