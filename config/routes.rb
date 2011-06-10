NeedOTron::Application.routes.draw do
  devise_for :users

  resources :needs do
    resources :justifications
  end
  
  root :to => "needs#index"
end
