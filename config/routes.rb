Plans::Application.routes.draw do

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
    end
    member do
      get :edit
      put :update
      get :show, as: 'read'
      get :search
      put :set_autofinger_subscription
    end
  end

  resources :secrets

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

  match '/register' => 'accounts#new', :as => :register
  match '/login' => 'account_sessions#new', :as => :login
  match '/logout' => 'account_sessions#destroy', :as => :logout

  # adding default route as lowest priority
  # match '/:controller(/:action(/:id))'
end
