require 'rails_helper'

describe Interface do
  it 'must have a path' do
    expect(described_class.create(path: nil)).to be_invalid
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
