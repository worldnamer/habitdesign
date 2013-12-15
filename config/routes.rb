Habitdesign::Application.routes.draw do
  resources :habits, only: [:index]

  devise_for :users, only: []
  devise_scope :user do
    get 'users/sign_in' => 'sessions#new', as: :new_user_session
    post 'users/sign_in' => 'sessions#create', as: :user_session
    get 'users/sign_out' => 'sessions#destroy', as: :destroy_user_session
  end

  root :to => 'welcome#index'
end
