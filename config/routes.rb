Plans::Application.routes.draw do
  # get "admin/add_hser"
  # get "admin/auth"
  # get "admin/change_motd"
  # get "admin/change_password"
  # get "admin/change_spec"
  # get "admin/delete_user"
  # get "admin/email"
  # get "admin/index"
  # get "admin/manage_donations"
  # get "admin/new_accounts"
  # get "admin/polls"
  # get "admin/secrets"
  # get "admin/style_stats"
  # get "admin/swap_password"
  # get "admin/update_frequency"

  # map.connect ':controller', :action => 'index'
  # map.connect 'read', :controller=>'accounts', :action => 'index'

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

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # See how all your routes lay out with "rake routes"

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :controller => "plans", :action => "show", :id => "plans"

  resource :plan, :only => [ :edit, :update ]
  resources :plans, :only => [ :show ], :as => "read"
  resource :user, :controller => "account_sessions", :as => "account_session", :only => [ :new, :create, :destroy ], :path_names => { :new => "login" }
end
