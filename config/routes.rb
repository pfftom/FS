Rails.application.routes.draw do
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]
  resources :leagues, only: [:index, :new, :create, :show] do
    resources :teams, only: [:new, :create]
  end
  resources :players, only: [:index]
  root to: "dashboards#show"
end
