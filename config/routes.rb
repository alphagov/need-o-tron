NeedOTron::Application.routes.draw do
  devise_for :users

  resources :needs do
    resources :justifications, :existing_services
  end
  
  root :to => "needs#index"
end
