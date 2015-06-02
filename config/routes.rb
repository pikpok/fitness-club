Rails.application.routes.draw do
  resources :reservations

  root 'static_pages#home'

  get 'cafe', to: "static_pages#cafe"

  resources :schedule, except: :show

  namespace :receptionist do
    root 'dashboard#index'
    get 'edit', to: 'dashboard#edit'
    patch 'edit', to: 'dashboard#update'
    resources :users, except: :show
  end

  namespace :admin do
    root 'dashboard#index'
    get 'edit', to: 'dashboard#edit'
    patch 'edit', to: 'dashboard#update'
    resources :receptionists, except: :show
    resources :users, except: :show
  end

  namespace :users do
    root 'dashboard#index'
    get 'dashboard/index'
    resources :reservation, except: :show
  end

  devise_for :admin
  devise_for :receptionist
  devise_for :user, controllers: { sessions: 'devise/sessions', :registrations => "users/registrations" }
end
