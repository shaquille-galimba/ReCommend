Rails.application.routes.draw do
	get '/signup' => 'users#new'
	post '/signup' => 'users#create'
	get '/login' => 'sessions#new'
	post '/login' => 'sessions#create'
	root 'sessions#new'
	delete '/logout' => 'sessions#destroy'

	#omniauth callback route
	get "/auth/:provider/callback" => "sessions#omniauth"

  resources :categories, only: [:index, :show] do
  	resources :recommends, only: [:new, :create]
  end
  resources :brands, only: [:index, :show] do
  	resources :recommends, only: [:new, :create]
  end
  resources :users, only: [:index, :show, :edit, :update, :destroy] do
  	resources :recommends, only: [:index]
  end
	resources :recommends
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
