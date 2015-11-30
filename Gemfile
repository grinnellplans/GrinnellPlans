source 'https://rubygems.org'

gem 'rails', '~> 4.2.0'

# our database, for now.  Eventually, it'll be msyql, but this is easier for now.
gem 'sqlite3'

# Capistrano is a sort of deployment script (https://github.com/capistrano/capistrano/wiki)
gem 'capistrano'

# haml is a lazy/concise way of generating html (http://haml-lang.com/)
gem 'haml'

# Sass is a lazy/concise way of preprocessing css (http://http://sass-lang.com/)
gem 'sass'

# A simple model based ruby authentication solution (https://github.com/binarylogic/authlogic)
gem 'authlogic'

# Helpers to deal with your model backed forms in Rails3  (https://github.com/joelmoss/dynamic_form)
gem 'dynamic_form'

# Crypt3 is a ruby version of crypt(3), a salted one-way hashing of a password.
# It is no longer maintained, but necessary to support conversion of old PHP hashed passwords.
gem 'crypt3', git: "git://github.com/rubyunworks/crypt3.git", tag: '2dd4c98ab2882c9233d70833886ad4588e7ff8e6'

# A whitelist-based Ruby HTML sanitizer (http://wonko.com/post/sanitize)
gem 'sanitize', '~> 2.0.3'

# A powerful parser for Markdown (https://github.com/tanoku/redcarpet)
gem 'redcarpet'

# https://github.com/rails/jquery-ujs
gem 'jquery-rails'

# https://github.com/mislav/will_paginate/tree/rails3
gem 'will_paginate', '~> 3.0'

# supports composite primary keys for legacy tables like Autfinger https://github.com/drnic/composite_primary_keys
gem "composite_primary_keys"

# Procfile management for ruby.
gem "foreman"

# Framework for building admin screens
# Version locked because it's still in beta and may have breaking changes
gem "administrate", "~> 0.1.1"

group :production do
  #email any errors to people specified in the environment.rb
  gem "exception_notification", git: "git://github.com/rails/exception_notification", require: 'exception_notifier'
end

group :development do
  #Mutes assets pipeline log messages.
  gem 'quiet_assets'

  # Handy in-browser console for debugging
  gem 'web-console'

  gem 'thin'
end

group :test, :development do
  # Tests! (http://relishapp.com/rspec)
  gem 'rspec-rails', '~> 3.0'

  #SanitizeEmail allows you to play with your application's email abilities without worrying that emails will get sent to actual live addresses. (https://github.com/pboling/sanitize_email)
  #gem 'sanitize_email'

  # Automated checking of code style and correctness
  gem 'rubocop'
end

group :test do

  gem 'factory_girl_rails'
  #Calculate the differences between two XML/HTML documents
  #If you have trouble installing nokogiri on lion: http://pinds.com/2011/08/06/rails-tip-of-the-day-rails-os-x-lion-rvm-nokogiri/
  gem 'nokogiri-diff'

  # Code coverage
  gem "simplecov"

end
