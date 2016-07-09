Rails.application.routes.draw do
  resources :players
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/' => 'homepage#home'
  get '/new' => 'players#new'
  get '/standings' => 'players#standings'
end
