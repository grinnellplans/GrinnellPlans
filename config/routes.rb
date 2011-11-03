Plans::Application.routes.draw do

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # See how all your routes lay out with "rake routes"

  # You can have the root of your site routed with "root"
  
  root :to => "plans#show"

  resource :plan, :only => [ :edit, :update ]
  resources :plans, :only => [ :show ], :as => "read"
  resources :secrets

  resource :user, :controller => "account_sessions", :as => "account_session", :only => [ :new, :create, :destroy ], :path_names => { :new => "login" }
  
  resources :accounts do
    collection do
      get :new
      post :create
      get :confirm
      post :resend_confirmation_email
      get :reset_password
    end
  end
    
  match '/register' => 'accounts#new'
  
  # adding default route as lowest priority
  # match '/:controller(/:action(/:id))'
end
