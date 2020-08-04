Rails.application.routes.draw do
	root 'application#welcome'
	get '/login' => 'session#new'
  resources :categories
  resources :brands
  resources :recommends
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
