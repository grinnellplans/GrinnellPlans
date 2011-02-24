class PollVote < ActiveRecord::Base
  set_primary_key :poll_vote_id
  belongs_to :account, :foreign_key=> :userid
  belongs_to :poll_choice, :foreign_key=> :poll_choice_id
  
end


# == Schema Information
#
# Table name: poll_votes
#
#  poll_vote_id   :integer(4)      not null, primary key
#  poll_choice_id :integer(4)
#  userid         :integer(4)
#  created        :datetime
#

