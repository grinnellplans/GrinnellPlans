require 'spec_helper'
describe BoardVote do
  before(:each) do
    @board_vote = FactoryGirl.build :board_vote
  end

  it 'is valid with valid attributes' do
    expect(@board_vote).to be_valid
  end

  it 'is not valid without an account' do
    @board_vote.account = nil
    expect(@board_vote).not_to be_valid
  end

  it 'is not valid without a main_board' do
    @board_vote.main_board = nil
    expect(@board_vote).not_to be_valid
  end

  it 'is not valid without a sub_board' do
    @board_vote.sub_board = nil
    expect(@board_vote).not_to be_valid
  end
end

# == Schema Information
#
# Table name: boardvotes
#
#  voteid    :integer         not null, primary key
#  userid    :integer(2)      default(0), not null
#  threadid  :integer(2)      default(0), not null
#  messageid :integer(2)      default(0), not null
#  vote_date :datetime        not null
#  vote      :integer(2)
#
