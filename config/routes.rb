Rails.application.routes.draw do
  resources :lines, only: [:index]
  resources :trains, only: [:index]
end
