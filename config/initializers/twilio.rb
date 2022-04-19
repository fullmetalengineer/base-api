Twilio.configure do |config|
  config.account_sid = ENV["TWILIO_ACCOUNT_SID"]
  config.auth_token = ENV["TWILIO_AUTH_TOKEN"]
  # raise "Environment variable TWILIO_ACCOUNT_SID not set" unless ENV['TWILIO_ACCOUNT_SID']
  # raise "Environment variable TWILIO_AUTH_TOKEN not set" unless ENV['TWILIO_AUTH_TOKEN']
end
