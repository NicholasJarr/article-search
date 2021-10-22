Rails.application.routes.draw do
  root 'articles#index'

  resources :articles
  resources :searches
end
