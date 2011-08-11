source 'http://rubygems.org'
source  'http://gems.github.com'

gem 'rails', '~> 3.0.9'

#our database, for now.  Eventually, it'll be msyql, but this is easier for now.
gem 'sqlite3'

#Capistrano is a sort of deployment script (https://github.com/capistrano/capistrano/wiki)
gem 'capistrano'

#haml is a lazy/concise way of generating html (http://haml-lang.com/) 
gem 'haml'

#A simple model based ruby authentication solution (https://github.com/binarylogic/authlogic)
gem 'authlogic', '~> 3.0.0'

#Helpers to deal with your model backed forms in Rails3  (https://github.com/joelmoss/dynamic_form)
gem 'dynamic_form'

#Crypt3 is a ruby version of crypt(3), a salted one-way hashing of a password.
gem 'crypt3'

#A whitelist-based Ruby HTML sanitizer (http://wonko.com/post/sanitize)
gem 'sanitize'

# A powerful parser for Markdown (https://github.com/tanoku/redcarpet)
gem 'redcarpet'

#https://github.com/rails/jquery-ujs
gem 'jquery-rails', '>= 0.2.6'

# https://github.com/mislav/will_paginate/tree/rails3
gem 'will_paginate', '~> 3.0.beta'

group :production do
  #email any errors to people specified in the environment.rb
  gem "exception_notification", :git => "git://github.com/rails/exception_notification", :require => 'exception_notifier'
end

group :development do
  #fancy-format things in the rails console.  "Hirb.enable" in the console to start it.
  gem 'hirb'
  
  #add comments to the models/tests that show the attributes
  gem 'annotate'
  
  # Generate model and controller diagrams and put them in /doc
  gem "railroady"
  
  #add a footer to the page with info about sql, javascript, etc.
  # gem 'rails3-footnotes'
  
  # To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
   gem 'ruby-debug'
  # gem 'ruby-debug19'
  
  gem "single_test"
end

group :test, :development do
  # Tests! (http://relishapp.com/rspec)
  gem 'rspec-rails'
  
  #SanitizeEmail allows you to play with your application's email abilities without worrying that emails will get sent to actual live addresses. (https://github.com/pboling/sanitize_email)
  #gem 'sanitize_email'
end

group :test do
  #Mocha is a library for mocking and stubbing 
  # gem 'mocha'
  
  gem 'factory_girl_rails'
  #Calculate the differences between two XML/HTML documents
  gem 'nokogiri-diff'
end
