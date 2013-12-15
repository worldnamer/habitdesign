source 'https://rubygems.org'

gem 'rails', '3.2.13'

gem 'jquery-rails'
gem 'jquery-ui-rails'

gem 'haml-rails' # markup templates

gem 'rails_bootstrap_navbar', git: 'git://github.com/worldnamer/Rails-Bootstrap-Navbar' # Helper methods for Twitter Bootstrap navbars
gem "twitter-bootstrap-rails"
gem 'bootstrap-datepicker-rails'

gem 'angularjs-rails', '>= 1.2.0.rc1' # DI/MVC framework for JS
gem 'ngmin-rails' # Allows for terser syntax in Angular

gem 'oj' # Optimized JSON (Oj) for speeding up serialization

gem 'devise' # Authentication

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  gem 'uglifier', '>= 1.0.3'

  gem "therubyracer"
  gem "less-rails" # LESS stylesheets
end

group :test do
  gem 'rspec-rails' # Unit testing
  gem 'database_cleaner', '~> 1.0.1' # JWLL: There's a bug in 1.1 that expects postgresql even if you're not using it
  gem 'debugger'
  gem 'timecop' # JWLL: Allows easy mocking of Time and Date
  gem 'factory_girl_rails', ">= 4.0" # Fixtures
  gem 'cucumber-rails', require: false # Acceptance testing

  # JWLL: There are some changes from 2.1.0 that haven't been released that fixes a bug in clicking on buttons that aren't in forms
  gem 'capybara', git: 'git://github.com/jnicklas/capybara'
  gem 'capybara-webkit'
end

group :development do
  gem 'sqlite3'
  gem 'debugger'
end

group :production do
  gem 'pg' # PostGres
end