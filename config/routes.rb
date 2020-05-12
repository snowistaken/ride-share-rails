Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "homepage#index"

  resources :drivers

  resources :passengers do
    resources :trips, only: [:index, :create]
  end

  resources :trips, except:[:new]
end