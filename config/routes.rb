Rails.application.routes.draw do
  devise_for :users
  mount LetterOpenerWeb::Engine, at: "/mail" if Rails.env.development?
  root  "blogs#index"
  resources :blogs
end
