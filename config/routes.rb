Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }

  devise_scope :user do
    get "signup", :to => "users/registrations#new"
    get "login", :to => "users/sessions#new"
    get "logout", :to => "users/sessions#destroy"
    post "users/guest_sign_in", to: "users/sessions#new_guest"
  end

  root 'static_pages#home'
  resources :users, only: [:show, :edit, :update]
  resources :users do
    member do
      get :followings, :followers
    end
  end

  resources :posts do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]
  get "search" => "posts#search"
  get "favorites" => "posts#favorites"
  get "rank" => "posts#rank"
  get "timeline" => "posts#timeline"
end
