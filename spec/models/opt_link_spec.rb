require 'spec_helper'

describe OptLink do
  it 'must have account' do
    expect(described_class.new(linknum: 1, userid: nil)).to be_invalid
  end
end

# == Schema Information
#
# Table name: opt_links
#
#  userid  :integer(2)      default(0), not null
#  linknum :integer(1)
#
