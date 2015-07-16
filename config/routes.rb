Rails.application.routes.draw do
  resources :bands do
    resource :albums, only: [:new]
  end

  resources :albums, except: [:index, :new] do
    resource :tracks, only: [:new]
  end

  resources :tracks, except: [:index, :new]

  resource :session, only: [:new, :create, :destroy]

  resources :users, only: [:show, :new, :create]
end
