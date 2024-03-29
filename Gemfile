# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", ">= 7.0.2.3"
# Specify version, per dependabot
gem "activesupport", ">= 7.0.2.3"
# Use postgresql as the database for Active Record
gem "pg", ">= 1.3.3"
# Use Puma as the app server
gem "puma", ">= 5.6.4"
# Specify version, per dependabot
gem "rack", ">= 2.2.3"
# Use Redis adapter to run Action Cable in production
gem "redis", ">= 4.6.0"
# Use ActiveModel has_secure_password
gem "bcrypt", "~> 3.1.7"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.1.0", require: false

# ==================== Rack Gems ====================
# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem "rack-attack"
gem "rack-cors", ">= 1.0.4"

# ==================== Background Jobs Gems ====================
gem "sidekiq", ">= 6.4.0"
gem "sidekiq-scheduler"

# ==================== Communication Gems ====================
gem "sendgrid-ruby"
gem "twilio-ruby"

# ==================== JSON Serialization Gems ====================
gem "blueprinter"
gem "oj"
gem "oj_mimic_json"

# ==================== Miscellaneous Gems ====================
gem "to_bool", "~> 2.0"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "factory_bot_rails"
end

group :development do
  gem "annotate"
  gem "dotenv-rails"
  gem "listen", ">= 3.0.5", "< 3.2"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end
