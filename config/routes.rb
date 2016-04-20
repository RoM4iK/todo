Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  root 'site#index'

  resources :projects, except: [:new, :edit], defaults: { format: :json }
end
