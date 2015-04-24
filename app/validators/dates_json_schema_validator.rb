
class DatesJsonSchemaValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, values)
    @record = record
    @attribute = attribute
    return add_error 'you should gave at least one date' if values.nil? || values.empty?
    values.each do |value|
      validate_date_object value
    end
  end

  private

  def parse_string_to_date(string)
    string.to_date
    rescue ArgumentError
      false
  end

  def add_error(error)
    @record.errors[@attribute] << (options[:message] || error)
  end

  def validate_date_object(value)
    return add_error 'each object should have "date", "from" and "to" key' unless value.is_a?(Hash) && validate_key_occurrence(value)
    check_is_future value
    check_hour_from_is_before_to value
  end

  def check_is_future(value)
    date = parse_string_to_date(value['date'])
    add_error "date #{value['date']} should be date" unless date
    add_error "date #{value['date']} should be in future" unless date.future?
  end

  def check_hour_from_is_before_to(value)
    hour_to = value['to'].delete(':').to_i
    hour_from = value['from'].delete(':').to_i
    add_error 'to hour should be before from hour' unless hour_to > hour_from
  end

  def validate_key_occurrence(value)
    %w(date from to).all? { |key| value.key?(key) }
  end
end
