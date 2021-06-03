Rails.application.routes.draw do
  get 'oauth_test/index'
  root  "blogs#index"
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  resources :users, only: [:show, :index]
  mount LetterOpenerWeb::Engine, at: "/mail" if Rails.env.development?
  resources :blogs
end
