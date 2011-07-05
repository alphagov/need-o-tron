NeedOTron::Application.routes.draw do

  match '/auth_start', :to => 'auth_start#index'
  match '/auth/gds/callback', :to => 'auth_start#show'

  resources :needs do
    resources :justifications, :existing_services
  end
  
  root :to => "needs#index", :defaults => { :in_state => 'new' }
end
