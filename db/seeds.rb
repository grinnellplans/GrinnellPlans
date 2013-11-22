require 'active_record/fixtures'

puts "Loading #{Rails.env} seeds"
Dir[Rails.root.join('db/seed', Rails.env, '*.yml')].each do |file|
  ActiveRecord::Fixtures.create_fixtures("db/seed/#{Rails.env}", File.basename(file, '.*'))
end
