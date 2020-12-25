Rails.application.routes.draw do
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
  resources :posts do
    resources :comments, only: [:create]
  end
end
