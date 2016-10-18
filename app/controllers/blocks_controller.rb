class BlocksController < ApplicationController
  before_filter :require_user

  def create
    blocked = params[:target]
    blocking = current_account.userid
    Block.find_or_create_by(blocking_user_id: blocking, blocked_user_id: blocked)
    redirect_to :back, notice: "You have blocked this user. Blocking a user is one-directional."\
    " Selecting \"Block\" renders the contents of your plan unavailable to this user."\
    " Neither will see any [planlove] by the other, and any updates either make will not show up on each other’s planwatch."\
    "\nIf this block was made in error, please use the option at the bottom of the page to un-do."
  end

  def destroy
    blocked = params[:target]
    blocking = current_account.userid
    b = Block.find_by(blocking_user_id: blocking, blocked_user_id: blocked)
    unless b.nil?
      b.destroy
    end
    redirect_to :back, notice: "User #{Account.find_by(userid: blocked).username} has been unblocked."
  end

  def index
    @account = Account.find_by_username(current_account.username)
    @blocks = Block.where(blocking_user_id: current_account.userid)
  end
end
