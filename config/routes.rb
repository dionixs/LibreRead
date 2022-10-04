# frozen_string_literal: true

Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    root 'static_pages#index'

    resource :session, only: %i[new create destroy]

    resources :users, only: %i[new create edit update]

    namespace :admin do
      resources :users, only: %i[index new create] do
        get 'upload', on: :new
      end
    end

    resources :imports, except: %i[edit update] do
      resources :notes, except: %i[new create]
    end
  end
end
