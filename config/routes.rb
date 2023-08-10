Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'
  resources :items
  get '/items/:id/destroy', to: 'items#redirect_to_top', as: :redirect_to_top
end
