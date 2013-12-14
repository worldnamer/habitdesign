Habitdesign::Application.routes.draw do
  resources :habits, only: [:index]

  devise_for :users, controllers: {sessions: "sessions"}

  root :to => 'welcome#index'
end
