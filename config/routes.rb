Rails.application.routes.draw do
  resources :wallets

  namespace :api do
    namespace :v1 do 
      resources :assets
      resources :users do
        collection do
          post :login
        end
      end
    end


  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
