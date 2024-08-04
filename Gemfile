 frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.2.2'

gem 'importmap-rails'
gem 'mysql2'
gem 'omniauth-google-oauth2'
gem 'omniauth-rails_csrf_protection'
gem 'pg'
gem 'propshaft'
gem 'puma'
gem 'rails'
gem 'turbo-rails'

group 'development' do
  gem 'brakeman', require: false
  gem 'erb_lint', require: false
  gem 'htmlbeautifier', require: false
end

group 'development', 'test' do
  gem 'bullet'
  gem 'rubocop', require: false
  gem 'rubocop-factory_bot', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rake', require: false
  gem 'rubocop-rspec', require: false
  gem 'rubocop-thread_safety', require: false
end

group 'test' do
  gem 'factory_bot_rails'
  gem 'rspec-rails', require: false
  gem 'simplecov', require: false
end
