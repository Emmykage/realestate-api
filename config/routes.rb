Rails.application.routes.draw do
  get 'session/create'
  
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
          post :forgot_password

        end
      end
      resources :password do
        collection do 
          post :forgot_password
        end
      end
       
      get 'portfolios_user/:id', to: "portfolios#portfolio_index"
      # get 'reset_password', to: 'users#reset_password', as: :password_reset_path

     
    end


  end

  get 'confirm_email', to: 'registration#confirm_email'
  get 'reset_password', to: 'password#reset_password'
  # get 'forgot_password', to: 'users#reset_password'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
