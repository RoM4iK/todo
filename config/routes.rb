Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  root 'site#index'

  shallow do
    resources :projects, except: [:new, :edit], defaults: { format: :json } do
      resources :tasks, except: [:new, :edit], defaults: { format: :json } do
        post 'move' => 'tasks#move'
        resources :comments, except: [:new, :edit], defaults: { format: :json }
      end
    end
  end
end
