class Admin::SecretsController < ApplicationController
  before_filter :require_admin, :load_autofingers
  # GET /admin/secrets
  def index
    @secrets = Secret.page(unsafe_params[:page]).order('date DESC')
  end

  def update
    @secret = Secret.find(unsafe_params[:id])
    @secret.display_attr = unsafe_params[:display_attr]
    if @secret.save
      render nothing: true
    else
      render action: 'index'
    end
  end
end
