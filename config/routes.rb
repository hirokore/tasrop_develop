Rails.application.routes.draw do
  get 'tops/index'
  get 'tops/contact'
  get 'tops/tutorial'
  get 'relationships/create'
  get 'relationships/destroy'
  root  'tops#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  resources :users, only: [:show, :index]
  mount LetterOpenerWeb::Engine, at: "/mail" if Rails.env.development?
  resources :blogs
  resources :relationships, only: [:create, :destroy]
  resources :conversations do
    resources :messages
  end
end
