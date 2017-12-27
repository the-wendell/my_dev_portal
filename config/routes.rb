Rails.application.routes.draw do
  root 'home#index'

  get 'dashboard/index'
  get 'dashboard/index/:menu_action' => 'dashboard#index'

  get ':portfolio' => 'portfolios#show'
  get 'portfolios/:id' => 'portfolios#edit'

  resources :portfolios, only: %i[create update destroy edit] do
    resources :projects
    resources :technologies
    resources :portfolio_headers
    resources :abouts
  end

  resources :users, only: %i[] do
    resources :job_applications
  end

  devise_for :users, controllers: { sessions: 'users/sessions',
                                    registrations: 'users/registrations',
                                    passwords: 'users/passwords'}
end
