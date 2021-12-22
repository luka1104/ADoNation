Rails.application.routes.draw do
  root 'home#index'
  get '/contact', to: 'home#contact'
  get '/aboutus', to: 'home#aboutus'
  get '/privacy', to: 'home#privacy'
  get '/terms', to: 'home#terms'
  get '/post_project', to: 'home#post_project'
  get 'users/:id/profile', to: 'users#show', as: 'user_profile'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  resources :users
  resources :projects do
    member do
      get :preview
    end
    resources :project_pvs
  end

  resources :admin, only: [:index] do
    member do
      put :active
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
