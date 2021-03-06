Rails.application.routes.draw do
  resources :auctions
  root :to =>'pages#home'
  
  get '/login' => 'session#new'
  post '/login' => 'session#create'
  delete '/login' => 'session#destroy'

  resources :users, :only => [:index, :new, :create, :edit, :update]  # no delete
  resources :solds
  resources :properties




  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
