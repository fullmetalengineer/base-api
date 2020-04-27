class TwilioService
    require 'twilio-ruby'
  
    def self.text(to, message)
        # Fire off the worker
        TwilioWorker.perform_async(to, message)
    end
  end
  