Plans::Application.routes.draw do

  # map.connect ':controller', :action => 'index'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
  
  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  
  # See how all your routes lay out with "rake routes"

  # You can have the root of your site routed with "root"
  
  # just remember to delete public/index.html.
  root :controller => "plans", :action => "show", :id => "plans"
  
  namespace :admin do
    resources :secrets, :only => [:index, :update]
    resources :accounts, :only => [:new, :create]
  end
  
  resources :plans do
    member do
      get :edit
      put :update
      get :show, :as => "read"
      get :search
    end
    collection do
      get :set_autofinger_level
      put :mark_level_as_read
    end
  end
  
  resources :secrets 

  resource :account_session, :only => [ :new, :create, :destroy ]
  
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
  match '/login' => 'account_sessions#new'
  match '/logout' => 'account_sessions#destroy'
  
  # adding default route as lowest priority
  # match '/:controller(/:action(/:id))'
end
