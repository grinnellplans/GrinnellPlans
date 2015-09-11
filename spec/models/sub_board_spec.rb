require 'rails_helper'

describe SubBoard do
  before(:each) do
    @sub_board = SubBoard.new(threadid: 1, userid: 1, contents: 'foo')
  end

  it 'is valid with valid attributes' do
    expect(@sub_board).to be_valid
  end

  it 'is not valid without a threadid' do
    @sub_board.threadid = nil
    expect(@sub_board).not_to be_valid
  end

  it 'is not valid without a userid' do
    @sub_board.userid = nil
    expect(@sub_board).not_to be_valid
  end

  it 'is not valid without contents' do
    @sub_board.contents = nil
    expect(@sub_board).not_to be_valid
  end

end
# == Schema Information
#
# Table name: subboard
#
#  messageid :integer         not null, primary key
#  threadid  :integer(2)      default(0), not null
#  created   :datetime
#  userid    :integer(2)      default(0), not null
#  title     :string(128)
#  contents  :text            not null
#
