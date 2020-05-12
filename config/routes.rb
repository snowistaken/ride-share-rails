Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "drivers#index"

  resources :drivers

  resources :passengers

  resources :trips, except:[:update]
end
