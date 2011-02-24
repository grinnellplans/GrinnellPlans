class SubBoard < ActiveRecord::Base
  set_table_name "subboard"
  set_primary_key :messageid
  belongs_to :main_board, :foreign_key =>:threadid
  belongs_to :account, :foreign_key=> :userid

  
end


# == Schema Information
#
# Table name: subboard
#
#  messageid :integer(2)      not null, primary key
#  threadid  :integer(2)      default(0), not null
#  created   :datetime
#  userid    :integer(2)      default(0), not null
#  title     :string(128)
#  contents  :text            default(""), not null
#

