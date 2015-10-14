class PollVote < ActiveRecord::Base
  self.primary_key = :poll_vote_id
  belongs_to :account, foreign_key: :userid
  belongs_to :poll_choice, foreign_key: :poll_choice_id
  validates_presence_of :account
end
