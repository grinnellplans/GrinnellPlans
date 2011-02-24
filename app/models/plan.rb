class Plan < ActiveRecord::Base
  belongs_to :account, :foreign_key=> :user_id
  def userid
    user_id
  end
end
# == Schema Information
#
# Table name: plans
#
#  id        :integer(2)      not null, primary key
#  user_id   :integer(2)
#  plan      :text(16777215)
#  edit_text :text
#

