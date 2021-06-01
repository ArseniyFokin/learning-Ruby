# frozen_string_literal: true

require 'dry-validation'

require_relative 'schema_types'
require_relative 'education_type'

# Form data validator class
class JobSeekerFormSchema < Dry::Validation::Contract
  params do
    required(:surname).filled(SchemaTypes::StrippedString)
    required(:name).filled(SchemaTypes::StrippedString)
    required(:patronymic).filled(SchemaTypes::StrippedString)
    required(:date_of_birth).filled(:date)
    required(:specialty).filled(SchemaTypes::StrippedString)
    required(:education).filled(SchemaTypes::StrippedString,
                                included_in?: EducationType.all_types)
    required(:desired_salary).filled(:integer, gteq?: 0)
    required(:unwanted_companies).maybe(SchemaTypes::StrippedString)
  end

  rule(:date_of_birth) do
    key.failure("date of birth is greater than today's date") if Date.today < value
  end
end
