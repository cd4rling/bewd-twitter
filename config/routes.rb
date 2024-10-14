Rails.application.routes.draw do
  root 'homepage#index'
  get '/feeds' => 'feeds#index'

  # USERS
  resources :users, only: [:create]
  # SESSIONS
  resources :sessions, only: [:create, :destroy] do
    collection do
      get 'authenticated'
    end
  end
  # TWEETS
  resources :tweets, only: [:index, :create, :destroy]
  get '/users/:username/tweets', to: 'tweets#index_by_user'
  
  # Redirect all other paths to index page, which will be taken over by AngularJS
  get '*path' => 'homepage#index'
end
