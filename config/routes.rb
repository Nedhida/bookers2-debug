Rails.application.routes.draw do

  resources :books do
    resource :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  devise_for :users
    resources :users,only: [:show,:index,:edit,:update] do
      resource :relationships, only: [:create, :destroy]
      member do
        get :following, :followers
      end
    end




  root 'homes#top'
  get 'home/about' => 'homes#about'

  get '/search', to: 'searchs#search'



end