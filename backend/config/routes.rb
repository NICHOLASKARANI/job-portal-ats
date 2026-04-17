Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'auth/register', to: 'auth#register'
      post 'auth/login', to: 'auth#login'
      get 'auth/me', to: 'auth#me'
      
      resources :jobs, only: [:index, :show, :create, :update, :destroy] do
        collection do
          get 'search'
        end
      end
      
      resources :applications, only: [:create, :index, :show, :update]
    end
  end
end