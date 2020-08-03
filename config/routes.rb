Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'trails', to: 'trails#index'
      get 'backgrounds', to: 'backgrounds#index'
      get '/forecast', to: 'forecasts#show'
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
