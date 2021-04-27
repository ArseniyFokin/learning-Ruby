# frozen_string_literal: true

# The class describes the movie
class Movie
  attr_reader :title, :kinopoisk, :imdb, :metacritic, :rotten_tomatoes

  include Comparable

  def initialize(movie)
    @title = movie['title']
    @kinopoisk = movie['kinopoisk'].to_f
    @imdb = movie['imdb'].to_f
    @metacritic = movie['metacritic'].to_f
    @rotten_tomatoes = movie['rotten_tomatoes'].to_f
  end

  def ogon_rating
    ((@imdb + @kinopoisk + (@metacritic + @rotten_tomatoes) / 2) / 3)
  end

  def <=>(other)
    ogon_rating <=> other.ogon_rating
  end

  def to_hash
    { 'title' => @title, 'kinopoisk' => @kinopoisk, 'imdb' => @imdb,
      'metacritic' => @metacritic, 'rotten_tomatoes' => @rotten_tomatoes,
      'ogon_rating' => ogon_rating }
  end

  def to_s
    "Movie #{@title}\nRating\n" \
    "Kinopoisk: #{format('%.1f', @kinopoisk)}\n" \
    "Imdb: #{format('%.1f', @imdb)}\n" \
    "Metacritic: #{format('%.1f', @metacritic)}\n" \
    "Rotten tomatoes: #{format('%.1f', @rotten_tomatoes)}\n" \
    "Ogon rating: #{format('%.1f', ogon_rating)}"
  end
end
