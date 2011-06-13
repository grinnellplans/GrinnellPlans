class SecretsController < ApplicationController
  before_filter :require_user
  
  # GET /secrets
  def index
    @secrets = Secret.all
  end

  # GET /secrets/1
  def show
    @secret = Secret.find(params[:id])
  end

  # GET /secrets/new
  def new
    @secret = Secret.new
  end

  # POST /secrets
  def create
    @secret = Secret.new(params[:secret])
      if @secret.save
        redirect_to(@secret, :notice => 'Secret was successfully created.') 
      else
        render :action => "new"
      end
  end

  # PUT /secrets/1
  def update
    @secret = Secret.find(params[:id])
    if @secret.update_attributes(params[:secret])
      redirect_to(@secret, :notice => 'Secret was successfully updated.') 
    else
      render :action => "edit" 
    end
  end

  # DELETE /secrets/1
  def destroy
    @secret = Secret.find(params[:id])
    @secret.destroy
    redirect_to(secrets_url)
  end
end
