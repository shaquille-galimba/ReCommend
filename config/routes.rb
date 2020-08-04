Rails.application.routes.draw do
	root 'application#welcome'
	get '/login' => 'sessions#new'
	post '/login' => 'sessions#create'
	delete '/logout' => 'sessions#destroy'
  resources :categories
  resources :brands
  resources :recommends
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
