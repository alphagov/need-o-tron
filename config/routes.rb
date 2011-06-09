NeedOTron::Application.routes.draw do
  resources :needs
  root :to => "home#index"
end
