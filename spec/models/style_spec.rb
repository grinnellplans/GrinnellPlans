require 'spec_helper'

describe Style do
  it "must have a path" do
    style = described_class.create(:path => nil).should be_invalid
  end
end
