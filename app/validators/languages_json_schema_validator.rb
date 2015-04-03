
class LanguagesJsonSchemaValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, values)
    @record = record
    @attribute = attribute
    return add_error 'you should gave at least one language' if values.nil? || values.empty?
    values.each do |value|
      validate_elem value
    end
  end

  private

  def add_error(error)
    @record.errors[@attribute] << (options[:message] || error)
  end

  def validate_elem(value)
    add_error 'each object should have "language" and "level" key' unless value.is_a?(Hash) && value.key?('language') && value.key?('level')
    add_error 'allowed level values: intermidiate, begginer, advanced' unless %w(intermidiate begginer advanced).include? value['level']
  end
end
