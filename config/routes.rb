Rails.application.routes.draw do

  resources :books
  devise_for :users
   resources :users,only: [:show,:index,:edit,:update]
  root 'homes#top'
  get 'home/about' => 'homes#about'

  resources :favorites, only: [:create, :destroy]

end