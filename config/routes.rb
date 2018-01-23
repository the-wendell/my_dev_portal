Rails.application.routes.draw do
  root 'home#index'
  patch 'select_active_portfolio' => 'dashboard/users#update'
  get ':portfolio' => 'front_end/portfolio#show'
  get 'preview/:portfolio' => 'front_end/portfolio#preview'

  scope module: 'dashboard' do
    resources :portfolios, only: %i[create update destroy edit] do
      resources :projects
      resources :technologies
      resources :portfolio_headers, only: %i[create update edit]
      resources :abouts
    end
    resources :users, only: %i[update] do
      resources :job_applications
      resources :portfolios, only: %i[create update destroy edit new]
      resources :dashboard, only: %i[index]
      resources :blogs, only: %i[show]
    end
  end

  devise_for :users, controllers: { sessions: 'users/sessions',
                                    registrations: 'users/registrations',
                                    passwords: 'users/passwords' }
end
