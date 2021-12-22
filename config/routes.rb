Rails.application.routes.draw do

  resources :books do
    resource :favorites, only: [:create, :destroy]
  end

  devise_for :users
   resources :users,only: [:show,:index,:edit,:update]
  root 'homes#top'
  get 'home/about' => 'homes#about'



end