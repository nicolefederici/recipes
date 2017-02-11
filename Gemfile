source 'http://rubygems.org'
ruby '2.3.1'

gem 'sinatra'
gem 'activerecord', :require => 'active_record'
gem 'sinatra-activerecord', :require => 'sinatra/activerecord'
gem 'rake'
gem 'require_all'
gem 'bcrypt'
gem 'sinatra-flash'

group :development do
  gem 'sqlite3'
  gem 'thin'
  gem 'shotgun'
  gem 'pry'
  gem "tux"
  gem 'rb-readline'
end

group :test do
  gem 'rspec'
  gem 'capybara'
  gem 'rack-test'
  gem 'database_cleaner', git: 'https://github.com/bmabey/database_cleaner.git'
end

group :production do
  gem 'pg'
  gem 'unicorn'
end