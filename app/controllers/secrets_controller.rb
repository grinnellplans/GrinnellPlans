class SecretsController < ApplicationController
  before_filter :require_user, :load_autofingers, except: [:new, :create]

  # GET /secrets
  def index
    @secrets = Secret.where(display: 'yes').page(unsafe_params[:page]).order('date DESC')
    @secret = Secret.new
  end

  # GET /secrets/new
  def new
    @secret = Secret.new
  end

  # POST /secrets
  def create
    @secret = Secret.new(unsafe_params[:secret])
    if @secret.save
      redirect_to(secrets_path, notice: 'Secret was successfully created.')
    else
      render action: 'new'
    end
  end

end
