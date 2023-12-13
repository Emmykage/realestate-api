Rails.application.routes.draw do
  
  namespace :api do
    namespace :v1 do 
      resources :earning_transactions
      resources :earnings
      resources :transactions
      resources :portfolios do
        resources :portfolio_interests
      end
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
      get 'portfolios_user/:id', to: "portfolios#portfolio_index"
    end


  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
