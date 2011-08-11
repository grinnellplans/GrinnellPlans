class SecretsController < ApplicationController
  before_filter :require_user
  
  
  # GET /secrets
  def index
    @secrets = Secret.where(:display=>"yes").paginate(:page => params[:page], :order=>"date DESC")
  end

  # GET /secrets/new
  def new
    @secret = Secret.new
  end

  # POST /secrets
  def create
    @secret = Secret.new(params[:secret])
      if @secret.save
        redirect_to(secrets_path, :notice => 'Secret was successfully created.') 
      else
        render :action => "new"
      end
  end

end