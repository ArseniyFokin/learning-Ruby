# frozen_string_literal: true

require_relative 'movie_list'

# The class describes the rating creator
class RatingCreator
  def create
    if ARGV.size != 2
      'Invalid number of arguments passed'
    elsif !File.file? ARGV[0]
      'Invalid input file path specified'
    else
      @movie_list = MovieList.new
      @movie_list.read_data(ARGV[0])
      @movie_list.save_sorted_list(ARGV[1])
      show_min_max
      list_movies
      show_rating
      @movie_list
    end
  end

  def show_min_max
    puts 'Lowest ogon rated movie:'
    puts @movie_list.min, "\n"
    puts 'Highest ogon rated movie:'
    puts @movie_list.max, "\n"
  end

  def list_movies
    @movie_list.each_with_index do |movie, index|
      puts index + 1, movie
    end
  end

  def show_rating
    puts "Average rating for all films: #{format('%.2f', @movie_list.average_ogon_rating)}"
  end
end
