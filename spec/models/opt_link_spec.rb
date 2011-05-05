require 'spec_helper'

describe OptLink do
  it "must have account" do
    described_class.new( :linknum => 1, :userid => nil ).should be_invalid
  end
end
