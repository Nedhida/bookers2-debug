Rails.application.routes.draw do

  resources :books do
    resource :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  devise_for :users
   resources :users,only: [:show,:index,:edit,:update] do
     member do
       get :following, :followers
     end
   end
  resources :relationships, only: [:create, :destroy]

  root 'homes#top'
  get 'home/about' => 'homes#about'



end