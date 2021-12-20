Rails.application.routes.draw do
  root 'home#index'
  get '/contact', to: 'home#contact'
  get '/aboutus', to: 'home#aboutus'
  get '/privacy', to: 'home#privacy'
  get '/terms', to: 'home#terms'
  get 'users/:id/profile', to: 'users#show', as: 'user_profile'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  resources :users
  # resource :home do
  #   member do
  #     get :contact
  #     get :privacy
  #     get :terms
  #     get :aboutus
  #   end
  # end
  resources :projects do
    member do
      get :preview
    end
    resources :project_pvs
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
