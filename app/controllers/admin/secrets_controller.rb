class Admin::SecretsController < ApplicationController
  before_filter :require_admin
  # GET /admin/secrets
  def index
    @secrets = Secret.page(params[:page]).order("date DESC")
  end

  def update
    @secret = Secret.find(params[:id])
    @secret.display = params[:display]
    if @secret.save
      render :nothing => true 
    else
      render :action => "index" 
    end
  end
  
end