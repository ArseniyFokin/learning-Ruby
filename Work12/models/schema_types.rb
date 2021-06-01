# frozen_string_literal: true

require 'dry-types'

# Types to use in schema validators
module SchemaTypes
  include Dry.Types

  StrippedString = self::String.constructor(&:strip)
end
