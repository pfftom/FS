Rails.application.routes.draw do
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]
  resources :leagues, only: [:index, :new, :create, :show] do
    resource :draft, only: [:show, :create, :update]
    resources :players, only: [:index]
    resources :teams, only: [:new, :create]
  end
  resources :players, only: [:index]
  root to: "dashboards#show"
end
