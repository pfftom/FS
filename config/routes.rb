Rails.application.routes.draw do
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]
  resources :leagues, only: [:index, :new, :create, :show] do
    resources :matchups, only: [:show]
    resource :draft, only: [:show, :create, :update]
    resources :players, only: [:index]
    resources :teams, only: [:new, :create, :show, :update]
  end

  resources :teams, only: [] do
    resource :rosters, only: [:create, :update, :destroy]
  end
  resources :players, only: [:index]
  root to: "dashboards#show"
end
