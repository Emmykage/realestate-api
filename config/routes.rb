Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do 
      resources :transactions
      resources :portfolios
      resources :wallets
    
      resources :assets
      resources :users do
        collection do
          post :login
          get :account
        end
      end
    end


  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
