# frozen_string_literal: true

require 'dry-schema'

AgeStatisticsSchema = Dry::Schema.Params do
  optional(:age).filled(:integer, gteq?: 0)
end
