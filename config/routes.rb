Plans::Application.routes.draw do
  namespace :admin do
    DashboardManifest::DASHBOARDS.each do |dashboard_resource|
      resources dashboard_resource
    end

    root controller: DashboardManifest::ROOT_DASHBOARD, action: :index
  end

  # For more information on routing, see http://guides.rubyonrails.org/routing.html.

  # just remember to delete public/index.html.
  root controller: 'plans', action: 'show', id: 'plans'

  namespace :admin do
    resources :secrets, only: [:index, :update]
    resources :accounts, only: [:new, :create]
  end

  resources :plans do
    collection do
      get :set_autofinger_level
      put :mark_level_as_read
      get :search, as: 'search'
    end
    member do
      get :edit
      put :update
      get :show, as: 'read'
      put :set_autofinger_subscription
    end
  end

  resources :secrets

  namespace :preferences do
    resource :links, controller: :avail_links, only: [:show, :update]
  end

  resource :account_session, only: [:new, :create, :destroy]

  resources :accounts do
    collection do
      get :new
      post :create
      get :confirm
      post :resend_confirmation_email
      get :reset_password
    end
  end

  resources :pages do
    get :faq
  end

  resources :password_resets, except: [:destroy, :show, :index]

  get '/register' => 'accounts#new', :as => :register
  get '/login' => 'account_sessions#new', :as => :login
  delete '/logout' => 'account_sessions#destroy', :as => :logout

  # Placeholder routes until we build the real things
  get "/" => "plans#show", as: :notes
  get "/" => "plans#show", as: :quicklove
  get "/" => "plans#show", as: :polls
  get "/" => "plans#show", as: :random_plan
  get "/" => "plans#show", as: :recently_updated_plans
  get "/" => "plans#show", as: :recently_created_plans

  # adding default route as lowest priority
  # match '/:controller(/:action(/:id))'
end
