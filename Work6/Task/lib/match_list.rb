# frozen_string_literal: true

require_relative 'match'

require 'csv'

# Simple class describing a list of matches
class MatchList
  include Enumerable

  def initialize
    @match_list = []
  end

  def read_csv(path)
    csv = CSV.read(path, headers: true, col_sep: ',')
    csv.each do |row|
      @match_list.push(Match.new(row))
    end
  end

  def each(&block)
    return enum_for(:each) unless block_given?

    @match_list.sort.each(&block)
  end

  def each_team_sort_name(&block)
    return enum_for(:each_team_sort_name) unless block_given?

    arr_team = map { |match| [match.team1, match.team2] }.flatten.uniq.sort
    arr_team.each(&block)
  end

  def each_team_sort_point(&block)
    return enum_for(:each_team_sort_point) unless block_given?

    team_point = Hash.new(0)
    each do |match|
      team_point[match.team1] += match.point1
      team_point[match.team2] += match.point2
    end
    team_point = team_point.to_a.sort_by { |team| -team[1] }
    team_point.each(&block)
  end
end
