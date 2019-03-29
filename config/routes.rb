Rails.application.routes.draw do
  resources :users
  resources :events
  resources :positions
  resources :employers
  resources :people
  resources :cities
  resources :sessions, only: [:new, :create, :destroy, :index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/', to: 'cities#home'
  get '/search', to: 'cities#search'
end
