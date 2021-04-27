# frozen_string_literal: true

require_relative '../lib/match_list'

require 'tty-prompt'

def main
  prompt = TTY::Prompt.new
  match_list = MatchList.new
  match_list.read_csv(File.expand_path('../data/match.csv', __dir__))
  iterator_table = match_list.each
  loop do
    puts iterator_table.next
    prompt.ask '>>>'
  end
  puts 'List of team names by points:'
  match_list.each_team_sort_point { |name, point| puts "#{name} - #{point}" }
  puts 'List of team:'
  match_list.each_team_sort_name { |name| puts name }
end

main if __FILE__ == $PROGRAM_NAME
