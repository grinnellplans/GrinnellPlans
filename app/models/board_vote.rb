class BoardVote  < ActiveRecord::Base
  self.table_name = "boardvotes"
  self.primary_key = :voteid
  belongs_to :account, :foreign_key=> :userid
  belongs_to :main_board, :foreign_key => :thredid
  belongs_to :sub_board, :foreign_key => :message_id
  validates_presence_of :main_board, :sub_board, :account, :vote_date

  before_update :set_vote_date
  private

  def set_vote_date
    self.vote_date = Time.now
  end

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

