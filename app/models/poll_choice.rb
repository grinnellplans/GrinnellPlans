class PollChoice < ActiveRecord::Base
  set_primary_key :poll_choice_id 
  belongs_to :poll_question
end


# == Schema Information
#
# Table name: poll_choices
#
#  poll_choice_id   :integer(4)      not null, primary key
#  poll_question_id :integer(4)
#  html             :text
#  created          :datetime
#

