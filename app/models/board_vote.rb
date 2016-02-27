class BoardVote < ActiveRecord::Base
  self.table_name = 'boardvotes'
  self.primary_key = :voteid
  belongs_to :account, foreign_key: :userid
  belongs_to :main_board, foreign_key: :threadid
  belongs_to :sub_board, foreign_key: :messageid
  validates_presence_of :main_board, :sub_board, :account, :vote_date
  validates_inclusion_of :vote, :in => [-1, 1], :allow_blank => true

  before_update :set_vote_date

  private

  def set_vote_date
    self.vote_date = Time.now
  end

end
