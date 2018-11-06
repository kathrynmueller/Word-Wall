Rails.application.routes.draw do
  resources :words
  root 'words#new'

  # get 'home/index'
  get 'wordwall' => 'words#wordwall'
  get 'index' => 'home#index' 
  post '/' => 'words#new' 
  post 'index' => 'home#index'

  get 'home/test'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
