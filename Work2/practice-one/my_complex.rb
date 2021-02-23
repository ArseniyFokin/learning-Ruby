# frozen_string_literal: true

class MyComplex
    attr_reader :real
    attr_reader :imaginary

    def initialize(real, imaginary)
        # Создаёт объекта комплексного числа
        @real = real.to_f
        @imaginary = imaginary.to_f
    end

    def to_s
        # Преобразует объект к строке
        "#{@real} + i * #{@imaginary}"
    end

    def add(other)
        # Суммирует комплексные числа
        MyComplex.new(@real + other.real, @imaginary + other.imaginary)
    end

    def sub(other)
        # Вычитает комплексные числа
        MyComplex.new(@real - other.real, @imaginary - other.imaginary)
    end

    def multiply(other)
        # Умножаете комплексные числа
        real_new = @real * other.real - @imaginary * other.imaginary
        imaginary_new = @real * other.imaginary + other.real * @imaginary
        MyComplex.new(real_new, imaginary_new)
    end

    def divide(other)
        # Делит комплексные числа
        denominator = (other.real ** 2 + other.imaginary ** 2)
        real_new = (@real * other.real + @imaginary * other.imaginary) / denominator
        imaginary_new = (other.real * @imaginary - @real * other.imaginary) / denominator
        MyComplex.new(real_new, imaginary_new)
    end

end