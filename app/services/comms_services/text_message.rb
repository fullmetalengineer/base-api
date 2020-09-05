# frozen_string_literal: true

require 'twilio-ruby'
module CommsService
  # Communicates with our configured text messaging platform
  module TextMessage
    def self.message(to, message)
      # Fire off the worker
      TwilioWorker.perform_async(to, message)
    end
  end
end
