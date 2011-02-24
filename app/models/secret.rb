class Secret < ActiveRecord::Base
  set_primary_key :secret_id
end


# == Schema Information
#
# Table name: secrets
#
#  secret_id     :integer(4)      not null, primary key
#  secret_text   :text
#  date          :datetime
#  display       :string(5)
#  date_approved :datetime
#

