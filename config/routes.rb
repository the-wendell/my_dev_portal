Rails.application.routes.draw do
  root 'home#index'

  get 'dashboard/index'
  get 'dashboard/index/:menu_action' => 'dashboard#index'

  get ':portfolio' => 'portfolios#show'

  resources :portfolios do
    resources :projects, only: %i[create update destroy]
    resources :technologies, only: %i[create update destroy]
    resources :portfolio_headers, only: %i[create update]
  end

  devise_for :users, controllers: { sessions: 'users/sessions',
                                    registrations: 'users/registrations' }
end
