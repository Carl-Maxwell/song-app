Rails.application.routes.draw do
  get 'notes/create'

  resources :bands do
    resource :albums, only: [:new]
  end

  resources :albums, except: [:index, :new] do
    resource :tracks, only: [:new]
  end

  resources :tracks, except: [:index, :new]

  resources :notes, only: [:create, :destroy]

  resource :session, only: [:new, :create, :destroy]

  resources :users, only: [:show, :new, :create]

  root "bands#index"
end
