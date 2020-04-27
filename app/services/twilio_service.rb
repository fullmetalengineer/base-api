class TwilioService
    require 'twilio-ruby'
  
    def self.send_text_message(to, message)
        # Fire off the worker
        TwilioWorker.perform_async(to, message)
    end
  end
  