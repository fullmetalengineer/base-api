# frozen_string_literal: true

# Helper class for handling error messages
#
# Methods: add(message), size, none?, all, as_sentence, convert
class CustomError
  def initialize(message=nil)
    @errors = []
    @errors << message unless message.blank?
  end

  def add(message)
    raise_if_no_message_provided(message)
    @errors << message
    self
  end

  def size
    @errors.size
  end

  def none?
    size.zero?
  end

  def all
    @errors
  end

  def as_sentence
    @errors.to_sentence.capitalize
  end

  def convert(errors)
    class_type = errors.class.to_s
    messages =  case class_type
                when "ActiveModel::Errors"
                  errors.full_messages
                when "Array"
                  errors
                else
                  errors&.errors&.full_messages || []
                end

    # Loop over the messages, adding them to the @errors array
    messages.each { |error| @errors << error }
    self
  end

  private

  def raise_if_no_message_provided(message)
    raise "Must provide usable error message!" if message.blank?
  end
end
