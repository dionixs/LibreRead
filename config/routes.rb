Rails.application.routes.draw do
  root 'static_pages#index'
  get 'import_clippings', to: 'import_clippings#new'
  post 'import_clippings', to: 'import_clippings#create'
end
