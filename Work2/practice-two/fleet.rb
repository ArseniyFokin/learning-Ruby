# frozen_string_literal: true

require 'json'
require_relative "auto"


class Fleet
    attr_reader :cars

    def initialize
        # Создаёт объект автомобиля
        @cars = []
    end

    def add(car)
        # Добавляет автомобиль в массив
        @cars.append(car)
    end

    def load_from_file(file_name)
        json_data = File.read(file_name)
        hash_array = JSON.parse(json_data)
        for car in hash_array do
            @cars.append(Auto.new(car["mark"], car["model"], car["year"], car["consumption"]))
        end
    end

    private
    def sum_gasoline_consumption(array)
        array.reduce(0.0) {|sum, car| sum + car.gasoline_consumption}
    end

    public
    def average_consumption
        sum_gasoline_consumption(@cars) / @cars.size
    end

    private
    def cars_by_brand(brand)
        @cars.find_all{|car| car.brand == brand}
    end

    public
    def number_by_brand(brand)
        cars_by_brand(brand).size
    end

    private
    def cars_by_model(model)
        @cars.find_all{|car| car.model == model}
    end

    public
    def number_by_model(model)
        cars_by_model(model).size
    end

    def consumption_by_brand(brand)
        c = cars_by_brand(brand)
        sum_gasoline_consumption(c) / c.size
    end
end