Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  root to: 'flats#index'

  devise_for :users

  namespace :account do
    resource :profile, only: %i(show edit update)
    resources :bookings, only: %i(index) do
      resource :accept, only: :create, controller: 'bookings/accept'
      resource :reject, only: :create, controller: 'bookings/reject'
    end
    resources :travels, only: %i(index show) do
      resource :payment, only: :create, controller: 'travels/payment'
      resource :cancel, only: :create, controller: 'travels/cancel'
    end
    resources :flats, only: %i(new create)
  end

  resources :flats, only: %i(index show) do
    resources :bookings, only: %i(new create)
    resources :reviews, only: %i(create)
  end

  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
