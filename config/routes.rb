Rails.application.routes.draw do
  root to: 'flats#index'

  devise_for :users

  namespace :account do
    resource :profile, only: %i(show edit update)
    resources :booking_requests, only: %i(index update)
    resources :travels, only: %i(index)
  end

  resources :flats, only: %i(index show new create) do
    resources :booking_requests, only: %i(new create)
  end

end
