# README

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* Deployment instructions

* ...

# Base API

This repo is the base of the Rails API starter I typically begin applications with. I will be expanding on it as I have time. It is built on Ruby 2.6.5 and Rails 6.0.2. I will be keeping it up-to-date as best I can.

# Gems

I try to use as few gems as possible to achieve what needs done. While there are many gems for doing nearly anything, I've found that they often add significant amounts of memory bloat, and that I can often implement the limited set of functionalities I need that the gem provides with just a little bit of work. So, keep it lean; Rails makes it very easy to run high-memory applications.

# Environment Variables

* `RAILS_MAX_THREADS` is the standard environment variable that tells Rails how many threads each worker process is allowed to spin up.

* `RAILS_MIN_THREADS` is the minimum number of threads each worker process should begin.

* `TWILIO_ACCOUNT_SID` is the unique identifier you're given for your account

* `TWILIO_AUTH_TOKEN` is the authorization token provided to you by Twilio when you sign up for an account.

* `TWILIO_DEFAULT_PHONE_NUMBER` is the default phone number from which your application will send messages. This may need to be re-implemented if you plan on having multiple phone numbers associated with your application.

* `SIDEKIQ_AUTH_USERNAME` is the username you use to sign into the Sidekiq web dashboard located at `/monitoring/sidekiq`

* `SIDEKIQ_AUTH_PASSWORD` is the password you use when signing into the Sidekiq web dashboard

# Test Suite

You can run the test suite by calling `rails test`. This project uses MiniTest.

# Background Processing

This project comes with Sidekiq and Sidekiq scheduler built-in as gems. Sidekiq leverages Redis, and Redis is provided as a gem. When running the application, you'll need to run Sidekiq alongside the normal Rails server in order for the background processing to work locally.

You may want to look into utilizing something like Foreman to turn on and off all of your services at once. Otherwise, you can start Sidekiq in a new terminal by running `bundle exec sidekiq`.
