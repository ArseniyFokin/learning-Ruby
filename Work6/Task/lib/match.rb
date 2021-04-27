# frozen_string_literal: true

# Simple class describing the match
class Match
  include Comparable

  attr_reader :team1, :team2, :score1, :score2

  def initialize(match)
    @team1 = match['team1']
    @team2 = match['team2']
    @score1 = match['score1'].to_i
    @score2 = match['score2'].to_i
    swap_team if @team1 > @team2
  end

  def swap_team
    @team1, @team2 = @team2, @team1
    @score1, @score2 = @score2, @score1
  end

  def point1
    point(@score1, @score2)
  end

  def point2
    point(@score2, @score1)
  end

  def point(score_first, score_second)
    if score_first > score_second
      3
    elsif score_first == score_second
      1
    else
      0
    end
  end

  def <=>(other)
    if @team1 == other.team1
      @team2 <=> other.team2
    else
      @team1 <=> other.team1
    end
  end

  def to_s
    "#{@team1}  #{@score1}:#{@score2}  #{team2}"
  end
end
