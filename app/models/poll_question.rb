class PollQuestion < ActiveRecord::Base
  set_primary_key :poll_question_id 
  has_many :poll_choices
end


# == Schema Information
#
# Table name: poll_questions
#
#  poll_question_id :integer(4)      not null, primary key
#  html             :text
#  type             :string(20)
#  created          :datetime
#

