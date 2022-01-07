Rails.application.routes.draw do

  resources :books do
    resource :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  devise_for :users
    resources :users,only: [:show,:index,:edit,:update] do
      get "search", to: "users#search"
      resource :relationships, only: [:create, :destroy]
      member do
        get :following, :followers
      end
    end


  resources :groups do
    member do
      get :join
    end
  end

  root 'homes#top'
  get 'home/about' => 'homes#about'

  get '/search', to: 'searchs#search'



end