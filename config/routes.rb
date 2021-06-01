Rails.application.routes.draw do
  devise_for :users
  mount LetterOpenerWeb::Engine, at: "/mail" if Rails.env.development?
  root  "blogs#index"
  resources :blogs
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
