Rails.application.routes.draw do
  root 'static_pages#index'
  get 'imports', to: 'import_clippings#index'
  get 'import_clippings', to: 'import_clippings#new'
  post 'import_clippings', to: 'import_clippings#create'
  get 'import_clippings/:id(.:format)', to: 'import_clippings#show'
  delete 'import_clippings/:id(.:format)', to: 'import_clippings#destroy'
end
