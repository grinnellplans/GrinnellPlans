require 'rails_helper'

describe Style do
  it 'must have a path' do
    expect(described_class.create(path: nil)).to be_invalid
  end

  describe 'path must be' do
    it 'valid if a css file' do 
      expect(described_class.create(path: 'hat/moose/loon.css')).to be_valid
    end
    it 'invalid if not a css file' do
      expect(described_class.create(path: 'hat/moose/loon.js')).to be_invalid
    end
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
