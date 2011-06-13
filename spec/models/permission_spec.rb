require 'spec_helper'

describe Permission do
   before(:each) do
     @permission = Permission.new(:account=>mock_model("Account"))
     
   end
end