Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "homepages#index"

  resources :drivers

  resources :passengers do
    resources :trips, only: [:index, :create, :update]
  end

  resources :trips, except: [:new]

  get "/trips/:id/rating", to: "trips#rating", as: "rating"
end
