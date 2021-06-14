Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/mail" if Rails.env.development?
  root  'tops#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  resources :users, only: [:show, :index, :edit, :destroy] do
    collection do
      get 'follow/:id', to: 'users#follow', as: 'follow'
      get 'followed/:id', to: 'users#followed', as: 'followed'
      get 'find', to: 'users#find', as: 'find'
      get 'result', to: 'users#result', as: 'result'
    end
  end

  resources :blogs
  resources :customs
  resources :relationships, only: [:create, :destroy]
  resources :conversations do
    resources :messages
  end
  resources :tops do
    collection do
      get 'tutorial'
    end
  end

end
