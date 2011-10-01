Plans::Application.routes.draw do |map|

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # See how all your routes lay out with "rake routes"

  # You can have the root of your site routed with "root"
  
  root :controller => "plans", :action => "show"
  resource :plan, :only => [ :edit, :update ]
  resources :plans, :only => [ :show ], :as => "read"
  resources :secrets
  resource :user, :controller => "account_sessions", :as => "account_session", :only => [ :new, :create, :destroy ], :path_names => { :new => "login" }
  match '/register' => 'accounts#new'
  
  # adding default route as lowest priority
  map.connect ':controller/:action'

end
