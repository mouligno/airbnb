Rails.application.routes.draw do
  root to: 'flats#index'

  devise_for :users

  namespace :account do
    resource :profile, only: %i(show edit update)
  end

  resources :flats, only: %i(index show new create)
end
