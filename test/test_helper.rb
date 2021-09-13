ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  setup do
    @super_user = User.create(first_name: "Alan", last_name: "Long", email: "alan.d.long@protonmail.com", password: 'MyPassword', password_confirmation: 'MyPassword')
    @token = @super_user.generate_token!('1.1.1.1')
    @super_user_headers = { "Authorization": "Bearer #{@token.value}" }
  end
  # Add more helper methods to be used by all tests here...
end
