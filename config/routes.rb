Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  root to: 'flats#index'

  devise_for :users

  namespace :account do
    resource :profile, only: %i(show edit update)
    resources :booking_requests, only: %i(index) do
      resource :accept, only: :create, controller: 'booking_requests/accept'
      resource :reject, only: :create, controller: 'booking_requests/reject'
    end
    resources :travels, only: %i(index)
    resources :flats, only: %i(new create)
  end

  resources :flats, only: %i(index show) do
    resources :booking_requests, only: %i(new create)
    resources :reviews, only: %i(create)
  end

  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
