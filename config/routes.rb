# frozen_string_literal: true

Rails.application.routes.draw do
  root 'static_pages#index'

  resources :sessions, only: %i[new create destroy]

  resources :users, only: %i[new create]

  resources :imports, except: %i[edit update] do
    resources :notes, except: %i[new create]
  end
end
