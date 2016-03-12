class BlockController < ApplicationController
  before_filter :require_user

  def create
    blocked = params[:target]
    blocking = current_account.userid
    Block.find_or_create_by(blocking_userid: blocking, blocked_userid: blocked)
    redirect_to :back
  end

  def destroy
    blocked = params[:target]
    blocking = current_account.userid
    b = Block.find_by(blocking_userid: blocking, blocked_userid: blocked)
    unless b.nil?
      b.destroy
    end
    redirect_to :back
  end
end
