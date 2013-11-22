require 'spec_helper'

describe Style do
  it 'must have a path' do
    described_class.create(path: nil).should be_invalid
  end
end

# == Schema Information
#
# Table name: style
#
#  style :integer         not null, primary key
#  path  :string(128)
#  descr :string(255)
#
