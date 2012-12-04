require 'spec_helper'

describe Interface do
  it "must have a path" do
    interface = described_class.create(:path => nil).should be_invalid
  end
end
