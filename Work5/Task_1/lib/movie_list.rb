# frozen_string_literal: true

require 'csv'

require_relative 'movie'

# The class describes the movie list
class MovieList
  include Enumerable

  def initialize
    @movies = []
  end

  def read_data(path)
    csv = CSV.read(path, headers: true, col_sep: ',')
    csv.each do |row|
      @movies.push(Movie.new(row))
    end
  end

  def save_sorted_list(path)
    headers = %w[title kinopoisk imdb metacritic rotten_tomatoes ogon_rating]
    sort_movies = @movies.sort.reverse
    CSV.open(path, 'w', col_sep: ',') do |csvfile|
      csvfile << headers
      sort_movies.each do |movie|
        csvfile << movie.to_hash.values
      end
    end
  end

  def each(&block)
    @movies.each(&block)
  end

  def average_ogon_rating
    sum_ogon_rating = reduce(0) do |memo, movie|
      memo + movie.ogon_rating
    end
    sum_ogon_rating / count
  end
end
