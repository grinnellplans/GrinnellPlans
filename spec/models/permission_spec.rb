require 'spec_helper'

describe Permission do
   before(:each) do
     @permission = Permission.new(account: mock_model('Account'))

   end
end

# == Schema Information
#
# Table name: perms
#
#  userid :integer         not null, primary key
#  status :string(32)
#
