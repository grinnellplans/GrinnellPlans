class HomeController < ApplicationController
 
  def index
  end
  
  def login
    @account = Account.new()
  end
  
end
