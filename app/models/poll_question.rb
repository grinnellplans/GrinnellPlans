class PollQuestion < ActiveRecord::Base
  self.primary_key = :poll_question_id
  has_many :poll_choices

 # don't use "type" as a column for Single table inheritance, it's a legacy name
  def self.inheritance_column
    'na'
  end
end
