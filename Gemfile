# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.2'

gem 'bootsnap', '>= 1.4.4', require: false
gem 'dclog'
gem 'jbuilder', '~> 2.7'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rack-cors'
gem 'rails', '~> 6.1.3', '>= 6.1.3.2'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.0'

group :development, :test do
  gem 'brakeman'
  gem 'pry-rails'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'spring'
  gem 'web-console', '>= 4.1.0'
end

group :test do
  gem 'factory_bot_rails', '~> 4.0'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
