# frozen_string_literal: true

require_relative "fleet"

def main
    car = Auto.new("Tesla", "Model 3", 2016, 0)
    fleet = Fleet.new
    fleet.add(car)
    fleet.load_from_file(File.expand_path('cars-list.json', __dir__))
    puts "Средний расход бензина у всех известных автомобилей #{fleet.average_consumption}"
    puts "Количество найденных автомобилей бренда 'Tesla': #{fleet.number_by_brand("Tesla")}"
    puts "Количество найденных автомобилей модели 'Civic 1,8i': #{fleet.number_by_model("Civic 1,8i")}"
    puts "Среднее потребление бензина для машин бренда 'BMW': #{fleet.consumption_by_brand("BMW")}"
end

main if __FILE__ == $PROGRAM_NAME