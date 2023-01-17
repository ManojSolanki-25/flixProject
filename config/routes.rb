Rails.application.routes.draw do
  resources :genres
  get "movies/filter/:filter" => "movies#index", as: :filtered_movies
  resources :users
  get "signup" =>"users#new"
  # verb "url" => "movie#index"
  get 'movies/index'
  resources :movies do
    resources :reviews
    resources :favorites, only: [:create,:destroy]
  end

  resource :session, only: [:new, :create, :destroy]
  get "signin" => "sessions#new"
  
  root  'movies#index'
  
  
 
  # get "/flix", to: "movies#index"
  # get "/flix/:id", to: "movies#show", as: "movie"
  # get "/flix/:id/edit", to: "movies#edit", as: "movie_edit"
  # patch "/flix/:id" => "movies#update"
  # get "/flix/new", to: "movies#new"
  # get "/flix", to: "movies#manoj"
end
