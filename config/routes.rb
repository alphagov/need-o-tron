NeedOTron::Application.routes.draw do
  resources :needs do
    collection do
      resource :imports, :only => [:new, :create]
    end
    resources :justifications, :existing_services, :directgov_links
    resources :sources
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

  match 'search(/*filters)' => 'search#index', as: 'filtered_search'
  match 'search' => 'search#index', as: 'search'
  root :to => "search#index"
end
