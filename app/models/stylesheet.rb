class Stylesheet < ActiveRecord::Base
  set_table_name "stylesheet"
  belongs_to :account, :foreign_key=> :userid
  
end



# == Schema Information
#
# Table name: stylesheet
#
#  userid     :integer         not null, primary key
#  stylesheet :text(255)
#

