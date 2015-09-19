class PollChoice < ActiveRecord::Base
  self.primary_key = :poll_choice_id
  belongs_to :poll_question
  has_many :poll_votes
end
