Rails.application.routes.draw do
  get 'technologies/create'

  get 'technologies/update'

  get 'technologies/destroy'

  resources :projects
  get 'dashboard/index'
  get 'dashboard/index/:menu_action' => "dashboard#index"

  get ':portfolio' => "portfolios#show"
  resources :portfolios
  devise_for :users, controllers: { sessions: 'users/sessions',
                                    registrations: 'users/registrations'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'home#index'
end
