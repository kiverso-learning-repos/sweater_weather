Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'road_trip', to: 'road_trip#create'
      post 'sessions', to: 'sessions#create'
      post 'users', to: 'users#create'
      get 'backgrounds', to: 'backgrounds#index'
      get '/forecast', to: 'forecasts#show'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
