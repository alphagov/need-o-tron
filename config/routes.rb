NeedOTron::Application.routes.draw do
  resources :needs do
    collection do
      post :importer
    end
    resources :justifications, :existing_services, :directgov_links
  end
  
  root :to => "needs#index", :defaults => { :in_state => 'new' }
end
