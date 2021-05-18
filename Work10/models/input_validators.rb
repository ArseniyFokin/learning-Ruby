# Validator for the incoming requests
module InputValidators
  def self.check_date_description(raw_date, raw_description)
    date = raw_date || ''
    description = raw_description || ''
    errors = []
    errors.concat(check_date_format(date)) unless date.empty?
    {
      date: date,
      description: description,
      errors: errors
    }
  end

  def self.check_date_format(date)
    unless /\d{4}-\d{2}-\d{2}/ =~ date
      ['The date must be sent in the format YYYY-MM-DD']
    else
      []
    end
  end

  def self.check_test(row_name, row_date, row_description)
    name = row_name || ''
    date = row_date || ''
    description = row_description || ''
    errors= [].concat(check_name(name)).concat(check_date(date)).concat(check_date_format(date))
    {
      name: name,
      date: date,
      description: description,
      errors: errors
    }
  end

  def self.check_name(name)
    if name.empty?
      ["Test name cannot be empty"]
    else
      []
    end
  end

  def self.check_date(date)
    if date.empty?
      ["Test date cannot be empty"]
    else
      []
    end
  end
end