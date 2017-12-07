Rails.application.routes.draw do
  get 'dashboard/index'
  get 'dashboard/index/:menu_action' => "dashboard#index"

  get ':portfolio' => "portfolios#show"
  resources :portfolios
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'home#index'
end
