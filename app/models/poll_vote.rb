class PollVote < ActiveRecord::Base
  self.primary_key = :poll_vote_id
  belongs_to :account, :foreign_key=> :userid
  belongs_to :poll_choice, :foreign_key=> :poll_choice_id
  
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

