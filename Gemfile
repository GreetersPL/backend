source 'https://rubygems.org'

ruby '2.2.2'

gem 'delayed_job_active_record'
gem 'email_validator'
gem 'i18n-tasks'
gem 'newrelic_rpm', '>= 3.9.8'
gem 'pg'
gem 'rack-timeout'
gem 'rails', '4.2.1'
gem 'recipient_interceptor'
gem 'title'
gem 'uglifier'
gem 'unicorn'
gem 'ember-cli-rails'
gem 'responders', '~> 2.0'
gem 'enumerize'
gem 'rack-cors', require: 'rack/cors'
gem 'annotate', '~> 2.6.6'
gem 'hipchat'

group :development do
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'web-console'
  gem 'rubocop'
  gem 'rubocop-rspec'
end

group :development, :test do
  gem 'awesome_print'
  gem 'bundler-audit', require: false
  gem 'byebug'
  gem 'dotenv-rails'
  gem 'factory_girl_rails'
  gem 'pry-rails'
  gem 'rspec-rails', '~> 3.2.1'
end

group :test do
  gem 'capybara-webkit'
  gem 'database_cleaner'
  gem 'formulaic'
  gem 'launchy'
  gem 'shoulda-matchers', require: false
  gem 'timecop'
  gem 'webmock'
  gem 'faker'
  gem "codeclimate-test-reporter"
end

group :staging, :production do
end
