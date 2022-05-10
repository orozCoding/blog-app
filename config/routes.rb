Rails.application.routes.draw do
  devise_for :users
  resources :users, only: %i[index show] do
    resources :posts, only: %i[index show new create] do
      resources :comments, only: %i[new create]
      resources :likes, only: %i[new create]
    end
  end

  # Defines the root path route ("/")
  root 'users#index'
  # api
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :users, only: %i[index show] do
        resources :posts, only: %i[index] do
          resources :comments, only: %i[index create]
        end
      end
    end
  end
end
