Rails.application.routes.draw do
  get 'users/:id/profile', to: 'users#show', as: 'user_profile'
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  resources :users
  resources :projects do
    member do
      get :preview
    end
    resources :project_pvs
  end
  
  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
