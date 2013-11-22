class Admin::SecretsController < ApplicationController
  before_filter :require_admin, :load_autofingers
  # GET /admin/secrets
  def index
    @secrets = Secret.page(params[:page]).order('date DESC')
  end

  def update
    @secret = Secret.find(params[:id])
    @secret.display_attr = params[:display_attr]
    if @secret.save
      render nothing: true
    else
      render action: 'index'
    end
  end

end
