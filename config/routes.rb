Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'
  resources :items do
    resources :purchase_records, only: :index
  end
  get '/items/:id/destroy', to: 'items#redirect_to_top', as: :redirect_to_top
end
