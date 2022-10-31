# frozen_string_literal: true

require 'sidekiq/web'

class AdminConstraint
  def matches?(request)
    user_id = request.session[:user_id] || request.cookie_jar.encrypted[:user_id]

    User.find_by(id: user_id)&.admin_role?
  end
end

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq', constraints: AdminConstraint.new

  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    get 'change_locale', to: 'locales#change_locale'

    namespace :admin do
      resources :users, only: %i[index new edit show update create destroy] do
        get 'upload', on: :new
      end
    end

    resource :session, only: %i[new create destroy]
    resources :users, only: %i[new create edit update destroy]
    resource :password_reset, only: %i[new create edit update]

    get 'dashboard', to: 'dashboard#index'

    resources :imports, except: %i[edit update] do
      get 'download', to: 'imports#download'
      post 'upload', to: 'imports#upload'
      resources :notes, except: %i[new create]
    end
  end

  root 'static_pages#index'
end
