source 'http://rubygems.org'
source  'http://gems.github.com'

gem 'rails', '3.0.4'
gem 'sqlite3'
gem 'capistrano'
gem 'haml'
gem 'authlogic'
gem 'dynamic_form'
gem 'crypt3'
gem 'sanitize', :git => "git://github.com/youngian/sanitize.git"

#https://github.com/rails/jquery-ujs
gem 'jquery-rails', '>= 0.2.6'

group :production do
  gem "exception_notification", :git => "git://github.com/rails/exception_notification", :require => 'exception_notifier'
end

group :development do
  gem 'hirb'
  gem 'annotate'
  gem "railroady"
  # gem 'rails3-footnotes'
  # To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
   gem 'ruby-debug'
  # gem 'ruby-debug19'
  gem "single_test"
end

group :test, :development do
  gem 'rspec-rails'
  gem 'mocha'
end
