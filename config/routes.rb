Rails.application.routes.draw do
  root 'static_pages#index'

  resources :imports, except: %i[edit update] do
    resources :notes, except: %i[new create]
  end
end
