# frozen_string_literal: true

require_relative '../lib/rating_creator'

def main
  rating_creator = RatingCreator.new
  result = rating_creator.create
  if result.instance_of?(String)
    puts result
    exit
  end
end

main if __FILE__ == $PROGRAM_NAME
