Rainforest::Application.routes.draw do

  resources :products do
    resources :reviews, :only => [:new, :create, :destroy]
  end
  resources :users, :only => [:new, :create]
  resources :sessions, :only => [:new, :create, :destroy]
  
end
