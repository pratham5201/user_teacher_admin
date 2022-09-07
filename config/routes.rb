Rails.application.routes.draw do
root "home#home"

  devise_for :users,
             controllers: {
                 sessions: 'users/sessions',
                 registrations: 'users/registrations'
             }
  # devise_for :users
  resources :notices
  # namespace :users do
  resources :users
  # end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
