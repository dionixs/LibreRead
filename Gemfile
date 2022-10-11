# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'activerecord-import',  '1.4.0'
gem 'bcrypt',               '3.1.18'
gem 'bootsnap',             '1.12.0', require: false
gem 'caxlsx',               '3.2.0'
gem 'caxlsx_rails',         '0.6.3'
gem 'cld',                  '0.11.0'
gem 'cssbundling-rails',    '1.1.1'
gem 'draper',               '4.0.2'
gem 'haml-rails',           '2.0.1'
gem 'jbuilder',             '2.11.5'
gem 'jsbundling-rails',     '1.0.3'
gem 'pagy',                 '5.10.1'
gem 'pg',                   '1.4.3'
gem 'puma',                 '5.6.5'
gem 'rails',                '7.0.3'
gem 'rails-i18n',           '7.0.5'
gem 'rubyXL',               '3.4.25'
gem 'rubyzip',              '2.3.2'
gem 'sidekiq',              '6.5.6'
gem 'slim-rails',           '3.5.1'
gem 'sprockets-rails',      '3.4.2'
gem 'turbo-rails',          '1.3.0'
gem 'valid_email2',         '4.0.4'

group :development, :test do
  gem 'awesome_print'
  gem 'byebug',              '11.1.3'
  gem 'debug',               '1.5.0', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails',   '6.2.0'
  gem 'faker',               '2.23.0'
  gem 'pry-rails'
  gem 'rspec-rails', '5.1.2'
end

group :development do
  gem 'brakeman'
  gem 'bullet'
  gem 'rails_best_practices'
  gem 'rails-erd'
  gem 'rubocop', '1.36.0', require: false
  gem 'rubocop-performance', '1.15.0', require: false
  gem 'rubocop-rails', '2.16.1', require: false
  gem 'web-console', '4.2.0'
end

group :test do
  gem 'capybara',             '3.37.1'
  gem 'selenium-webdriver',   '4.2.0'
  gem 'webdrivers',           '5.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem.
# Uncomment the following line if you're running Rails
# on a native Windows system:
# gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Use Redis for Action Cable
gem "redis", "~> 4.0"
