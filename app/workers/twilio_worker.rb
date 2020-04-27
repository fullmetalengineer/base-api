class TwilioWorker
    include Sidekiq::Worker
    sidekiq_options queue: 'communication', retry: false
    require 'twilio-ruby'
  
    def perform(to, message)
        # Set up the required environment variables
        account_sid = ENV['TWILIO_ACCOUNT_SID']
        auth_token = ENV['TWILIO_AUTH_TOKEN']
        twilio_phone_number = ENV['TWILIO_DEFAULT_PHONE_NUMBER']

        # Raise errors if environment variables not set
        raise "Environment variable TWILIO_ACCOUNT_SID not set" unless account_sid
        raise "Environment variable TWILIO_AUTH_TOKEN not set" unless auth_token
        raise "Environment variable TWILIO_DEFAULT_PHONE_NUMBER not set" unless twilio_phone_number

        # Send the text
        client = Twilio::REST::Client.new account_sid, auth_token
        message = client.messages.create(from: twilio_phone_number.to_s, to: to.to_s, body: message)
        puts message.sid
    end
  end
  