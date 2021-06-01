# frozen_string_literal: true

require 'dry-validation'

require_relative 'schema_types'
require_relative 'education_type'

# Form data validator class
class VacancyFormSchema < Dry::Validation::Contract
  params do
    required(:company).filled(SchemaTypes::StrippedString)
    required(:title).filled(SchemaTypes::StrippedString)
    required(:department).filled(SchemaTypes::StrippedString)
    required(:salary).filled(:integer, gteq?: 0)
    required(:age_interval).filled(SchemaTypes::StrippedString)
    required(:education).filled(SchemaTypes::StrippedString,
                                included_in?: EducationType.all_types)
    required(:count_vacancy).filled(:integer, gteq?: 0)
  end

  rule(:age_interval) do
    if /^[0-9]{1,}-[0-9]{1,}$/.match?(value)
      ages = value.split('-').map(&:to_i)
      key.failure('the lower limit is greater than the upper limit') unless ages[0] <= ages[1]
    else
      key.failure('has invalid format')
    end
  end
end
