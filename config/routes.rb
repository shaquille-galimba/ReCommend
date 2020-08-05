Rails.application.routes.draw do
	root 'application#index'
	get '/signup' => 'users#new'
	post '/signup' => 'users#create'
	get '/login' => 'sessions#new'
	post '/login' => 'sessions#create'
	delete '/logout' => 'sessions#destroy'

	#omniauth callback route
	get "/auth/:provider/callback" => "sessions#omniauth"
  resources :categories
  resources :brands
  resources :recommends
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
