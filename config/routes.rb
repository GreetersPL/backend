Rails.application.routes.draw do
  namespace :api, path: '', defaults: { format: 'json' }, constraints: { subdomain: 'api' }  do
    namespace :v1 do
      resources :walks, only: [:create]
      resources :signups, only: [:create]
    end
  end

  namespace :admin, path: '', constraints: { subdomain: 'admin' } do
    root to: 'admin#index'
  end
end
