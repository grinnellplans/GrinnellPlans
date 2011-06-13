require 'spec_helper'
describe AvailLink do
  before(:each) do
    @avail_link = AvailLink.new()
  end
  
  it "is valid with valid attributes" do
    @avail_link.should be_valid
  end
  
end