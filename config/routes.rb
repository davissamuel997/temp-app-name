Rails.application.routes.draw do
  get "static/index"
  root :to => 'static#index'
  resources :posts
end
