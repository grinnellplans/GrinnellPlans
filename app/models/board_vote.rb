class BoardVote  < ActiveRecord::Base
  set_table_name "boardvotes"
  set_primary_key :voteid
  belongs_to :account, :foreign_key=> :userid

end


# == Schema Information
#
# Table name: boardvotes
#
#  voteid    :integer         not null, primary key
#  userid    :integer(2)      default(0), not null
#  threadid  :integer(2)      default(0), not null
#  messageid :integer(2)      default(0), not null
#  vote_date :datetime        not null
#  vote      :integer(2)
#

