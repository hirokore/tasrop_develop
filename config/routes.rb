Rails.application.routes.draw do
  root  "blogs#index"
  resources :users, only: [:show, :index]
  devise_for :users
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  mount LetterOpenerWeb::Engine, at: "/mail" if Rails.env.development?
  resources :blogs
end
