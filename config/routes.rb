Rails.application.routes.draw do
  root 'static_pages#home'

  get 'static_pages/help'

  namespace :receptionist do
    root 'dashboard#index'
    get 'dashboard/index'
    resources :users do
      collection do
        patch 'update_password'
      end
    end
  end

  namespace :admin do
    root 'dashboard#index'
    get 'edit', to: 'dashboard#edit'
    patch 'edit', to: 'dashboard#update'
    resources :receptionists
    resources :users
  end

  namespace :users do
    root 'dashboard#index'
    get 'dashboard/index'
  end

  devise_for :admin
  devise_for :receptionist
  devise_for :user, controllers: { sessions: 'devise/sessions', :registrations => "users/registrations" }
end
