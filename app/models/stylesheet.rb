class Stylesheet < ActiveRecord::Base
  set_table_name "stylesheet"
  belongs_to :account, :foreign_key=> :userid
  
end

# == Schema Information
#
# Table name: stylesheet
#
#  userid     :integer(2)      default(0), not null
#  stylesheet :text(255)
#

