NeedOTron::Application.routes.draw do
  resources :needs do
    collection do
      resource :imports, :only => [:new, :create]
    end
    resources :justifications, :existing_services, :directgov_links
    resources :fact_checkers do
      collection do
        get :search
      end
    end
    resources :accountabilities do
      collection do
        get :search
      end
    end
    member do
    	get 'print'
    end
  end
  
  root :to => "needs#index", :defaults => { :in_state => 'new' }
end
