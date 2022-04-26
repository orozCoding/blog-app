Rails.application.routes.draw do
  get '/users/', to: "users#index"
  get '/users/:id', to: "users#show"
  get '/users/:id/posts', to: "users#posts"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
