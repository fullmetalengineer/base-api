# frozen_string_literal: true

# Standardizes what a service method should always return
module ServiceContract
  # Create the contractual return object
  def self.sign(success:, payload:, errors:)
    ServiceInterface.new({ success: success, payload: payload, errors: convert_to_custom_error(errors) })
  end

  def self.success(payload)
    ServiceInterface.new({ success: true, payload: payload, errors: convert_to_custom_error(nil) })
  end

  def self.error(errors)
    ServiceInterface.new({ success: false, payload: nil, errors: convert_to_custom_error(errors) })
  end

  # Convert a string, an array of strings, or a model's errors to a CustomError instance
  def self.convert_to_custom_error(errors)
    case errors.class.name.to_sym
    when :String, :NilClass
      custom_error = CustomError.new(errors)
    when :Array
      custom_error = CustomError.new
      errors.each { |e| custom_error.add(e) }
    else
      custom_error = CustomError.new.convert(errors)
    end
    custom_error
  end
end
