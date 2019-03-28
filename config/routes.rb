Rails.application.routes.draw do
  resources :events
  resources :positions
  resources :employers
  resources :people
  resources :cities
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/', to: 'cities#home'
  get '/search', to: 'cities#search'
end
