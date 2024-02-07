Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/register', to: 'registrations#create'
      post '/login', to: 'sessions#create'
      resources :gimnasios, only: [] do
        resources :clientes
      end
      resources :clientes do
        collection do
          get 'clientes_exp', to: 'clientes#clientes_exp'
        end
      end
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
