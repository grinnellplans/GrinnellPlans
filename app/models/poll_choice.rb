class PollChoice < ActiveRecord::Base
  self.primary_key = :poll_choice_id
  belongs_to :poll_question
  has_many :poll_votes
end



# == Schema Information
#
# Table name: poll_choices
#
#  poll_choice_id   :integer         not null, primary key
#  poll_question_id :integer
#  html             :text
#  created          :datetime
#
