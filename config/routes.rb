Rails.application.routes.draw do

  resources :books
  devise_for :users
   resources :users,only: [:show,:index,:edit,:update]
  root 'homes#top'
  get 'home/about' => 'homes#about'

  post "favorites/:book_id/create" => "likes#create"
  post "favorites/:book_id/destroy" => "likes#destroy"

end