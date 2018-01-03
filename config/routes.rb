Rails.application.routes.draw do
  root 'home#index'

  get 'dashboard/index'

  patch 'select_active_portfolio' => 'users#update'

  get ':portfolio' => 'portfolios#show'
  get 'portfolios/:id' => 'portfolios#edit'

  resources :portfolios, only: %i[create update destroy edit] do
    resources :projects
    resources :technologies
    resources :portfolio_headers
    resources :abouts
  end

  resources :users, only: %i[update] do
    resources :job_applications
    resources :portfolios, only: %i[create update destroy edit new]
  end

  devise_for :users, controllers: { sessions: 'users/sessions',
                                    registrations: 'users/registrations',
                                    passwords: 'users/passwords'}
end
