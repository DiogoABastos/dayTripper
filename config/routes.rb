Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/profile', to: 'pages#profile'
  patch '/profile', to: 'pages#update_profile'

  get '/404', to: 'errors#not_found'
  get '/500', to: 'errors#internal_error'
  get '/422', to: 'errors#unacceptable'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :itineraries do
    member do
      post "reorder", to: "locations#change_order"
    end
    resources :locations
    resources :reviews, only: [:new, :create]
    member do
      post 'clone', to: "itineraries#clone"
    end
  end

end
