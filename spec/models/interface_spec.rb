require 'spec_helper'

describe Interface do
  it 'must have a path' do
    interface = described_class.create(path: nil).should be_invalid
  end
end

# == Schema Information
#
# Table name: interface
#
#  interface :integer         not null, primary key
#  path      :string(128)
#  descr     :string(255)
#
