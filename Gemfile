source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'bcrypt',             '3.1.18'
gem 'bootsnap',           '1.12.0', require: false
gem 'cssbundling-rails',  '1.1.1'
gem 'draper',             '4.0.2'
gem 'haml-rails',         '2.0.1'
gem 'jbuilder',           '2.11.5'
gem 'jsbundling-rails',   '1.0.3'
gem 'pagy',               '5.10.1'
gem 'pg',                 '1.4.3'
gem 'puma',               '5.6.5'
gem 'rails',              '7.0.3'
gem 'rails-i18n',         '7.0.5'
gem 'sidekiq',            '6.5.6'
gem 'sprockets-rails',    '3.4.2'
gem 'valid_email2',       '4.0.4'

group :development, :test do
  gem 'debug',    '1.5.0', platforms: %i[mri mingw x64_mingw]
  gem 'faker',    '2.23.0'
  gem 'rubocop',  '1.36.0'
end

group :development do
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
