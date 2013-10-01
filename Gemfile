source 'http://rubygems.org'
source  'http://gems.github.com'

ruby '1.9.3'

gem 'rails', '~> 3.2'


# our database, for now.  Eventually, it'll be msyql, but this is easier for now.
gem 'sqlite3'

# Capistrano is a sort of deployment script (https://github.com/capistrano/capistrano/wiki)
gem 'capistrano'

# haml is a lazy/concise way of generating html (http://haml-lang.com/)
gem 'haml'

# Sass is a lazy/concise way of preprocessing css (http://http://sass-lang.com/)
gem 'sass'

# A simple model based ruby authentication solution (https://github.com/binarylogic/authlogic)
gem 'authlogic', '~> 3.1.2'
gem 'rails3-generators'

# Helpers to deal with your model backed forms in Rails3  (https://github.com/joelmoss/dynamic_form)
gem 'dynamic_form'

# Crypt3 is a ruby version of crypt(3), a salted one-way hashing of a password.
# It is no longer maintained, but necessary to support conversion of old PHP hashed passwords.
gem 'crypt3', :git => "git://github.com/rubyunworks/crypt3.git"

# A whitelist-based Ruby HTML sanitizer (http://wonko.com/post/sanitize)
gem 'sanitize'

# A powerful parser for Markdown (https://github.com/tanoku/redcarpet)
gem 'redcarpet'

# Serialization using JSON
gem "json", "~> 1.5.4"

# https://github.com/rails/jquery-ujs
gem 'jquery-rails', '~> 2.1'

# https://github.com/mislav/will_paginate/tree/rails3
gem 'will_paginate', '~> 3.0.pre4'

# supports composite primary keys for legacy tables like Autfinger https://github.com/drnic/composite_primary_keys
gem "composite_primary_keys", "~> 5.0"

# Procfile management for ruby.
gem "foreman"

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
  #gem 'ruby-debug', :platform => :ruby_18
  gem 'ruby-debug19', :platform => :ruby_19

  gem "single_test"

  #makes the error pages much more useful and makes them look better
  gem 'better_errors'
  
  #Using binding_of_caller we can grab bindings from higher up the call stack and evaluate code in that context. 
  #development only
  gem 'binding_of_caller'
  #Supporting gem for Rails Panel (Google Chrome extension for Rails development).
  gem 'meta_request'
  #Mutes assets pipeline log messages.
  gem 'quiet_assets'
  
  gem 'thin'

end

group :test, :development do
  # Tests! (http://relishapp.com/rspec)
  gem 'rspec-rails'

  #SanitizeEmail allows you to play with your application's email abilities without worrying that emails will get sent to actual live addresses. (https://github.com/pboling/sanitize_email)
  #gem 'sanitize_email'
end

group :test do

  gem 'factory_girl_rails'
  #Calculate the differences between two XML/HTML documents
  #If you have trouble installing nokogiri on lion: http://pinds.com/2011/08/06/rails-tip-of-the-day-rails-os-x-lion-rvm-nokogiri/
  gem 'nokogiri-diff'
  #Code coverage
  gem "simplecov"

end