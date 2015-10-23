require 'rails_helper'

describe PollVote do
  it 'must have an account' do
    poll_vote = described_class.create(account: nil).should be_invalid
  end
end
# == Schema Information
#
# Table name: poll_votes
#
#  poll_vote_id   :integer         not null, primary key
#  poll_choice_id :integer
#  userid         :integer
#  created        :datetime
#
