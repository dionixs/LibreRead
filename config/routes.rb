# frozen_string_literal: true

Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    get 'change_locale', to: 'locales#change_locale'

    namespace :admin do
      resources :users, only: %i[index new edit update create destroy] do
        get 'upload', on: :new
      end
    end

    resource :session, only: %i[new create destroy]
    resources :users, only: %i[new create edit update destroy]

    resources :imports, except: %i[edit update] do
      get 'download', to: 'imports#download'
      resources :notes, except: %i[new create]
    end
  end

  root 'static_pages#index'
end
