Rails.application.routes.draw do
  resources :portfolio_interests
  
  namespace :api do
    namespace :v1 do 
      resources :transactions
      resources :portfolios
      resources :wallets
      resources :blogs
      resources :assets
      resources :users do
        collection do
          post :login
          get :account
          patch :update_account
        end
      end
    end


  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
