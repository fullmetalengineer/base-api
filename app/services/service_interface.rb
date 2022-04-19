# frozen_string_literal: true

# This class is what every ServiceContract will return under the hood
class ServiceInterface
  attr_reader :success, :payload, :errors

  def initialize(success:, payload: nil, errors: nil)
    @success = success
    @payload = payload
    @errors = errors
  end

  def success?
    @success
  end
end
