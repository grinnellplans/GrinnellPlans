class SecretsController < ApplicationController
  # Intentionally allowing unauthenticated users to post secrets
  before_filter :load_autofingers

  # GET /secrets
  def index
    if current_account.present?
      @secrets = Secret.where(display: 'yes').page(params[:page]).order('date DESC')
    end
    @secret = Secret.new
  end

  # POST /secrets
  def create
    @secret = Secret.new(secret_params)
    if @secret.save
      redirect_to(secrets_path, notice: 'Secret was successfully created.')
    else
      render action: 'index'
    end
  end

  def secret_params
    params.require(:secret).permit(:secret_text)
  end

end
