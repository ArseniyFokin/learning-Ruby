# frozen_string_literal: true

class Auto
    attr_reader :brand
    attr_reader :model
    attr_reader :manifacture_year
    attr_reader :gasoline_consumption

    def initialize(brand, model, manifacture_year, gasoline_consumption)
        # Создаёт объект
        @brand = brand
        @model = model
        @manifacture_year = manifacture_year.to_i
        @gasoline_consumption = gasoline_consumption.to_f
    end

    def to_s
        # Преобразует к строке
        "Марка автомобиля: #{@brand}\nМодель автомобиля: #{@model}\n" + 
        "Год выпуска: #{@manifacture_year}\nСредний расход бензина на 100 километров: #{@gasoline_consumption}"
    end
end