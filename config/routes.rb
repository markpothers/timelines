Rails.application.routes.draw do
  resources :events
  resources :positions
  resources :employers
  resources :people
  resources :cities
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
