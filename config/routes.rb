Plans::Application.routes.draw do

  namespace :admin do
    resources :accounts
    resources :autofingers
    resources :avail_links
    resources :board_votes
    resources :custom_stylesheets
    resources :display_preferences
    resources :interfaces
    resources :main_boards
    resources :opt_links
    resources :permissions
    resources :plans
    resources :poll_choices
    resources :poll_questions
    resources :poll_votes
    resources :secrets
    resources :styles
    resources :sub_boards
    resources :systems
    resources :tentative_accounts
    resources :viewed_secrets

    root to: "accounts#index"
  end

  mount Forem::Engine, :at => '/notes'

  # For more information on routing, see http://guides.rubyonrails.org/routing.html.

  # just remember to delete public/index.html.
  root controller: 'plans', action: 'show', id: 'plans'

  resources :plans do
    collection do
      get :set_autofinger_level
      put :mark_level_as_read
      get :search, as: 'search'
      get :planwatch
    end
    member do
      get :edit
      put :update
      get :show, as: 'read'
      put :set_autofinger_subscription
    end
  end

  resources :secrets

  resources :preferences, only: [:index]
  namespace :preferences do
    resource :account, controller: :account_details, only: [:show, :update]
    resource :display, controller: :display, only: [:show, :update]
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

  resources :blocks, only: [:index, :create, :destroy] do
    get :about, on: :collection
  end

  get '/register' => 'accounts#new', :as => :register
  get '/login' => 'account_sessions#new', :as => :login
  delete '/logout' => 'account_sessions#destroy', :as => :logout

  # Placeholder routes until we build the real things
  get "/" => "plans#show", as: :quicklove
  get "/" => "plans#show", as: :polls
  get "/" => "plans#show", as: :random_plan
  get "/" => "plans#show", as: :recently_created_plans

  # adding default route as lowest priority
  # match '/:controller(/:action(/:id))'
end
