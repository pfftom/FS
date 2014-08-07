Rails.application.routes.draw do
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]
  resources :leagues, only: [:index, :new, :create]
  resources :players, only: [:index]
  root to: "dashboards#show"
end
