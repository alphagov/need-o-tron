NeedOTron::Application.routes.draw do
  devise_for :users

  resources :needs
  root :to => "home#index"
end
