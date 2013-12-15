Habitdesign::Application.routes.draw do
  resources :habits, only: [:index, :create, :update] do
    member do
      post "days/:date" => 'habits#set_date'
      delete "days/:date" => 'habits#remove_date'
    end
  end

  devise_for :users, only: []
  devise_scope :user do
    get 'users/sign_in' => 'sessions#new', as: :new_user_session
    post 'users/sign_in' => 'sessions#create', as: :user_session
    get 'users/sign_out' => 'sessions#destroy', as: :destroy_user_session
    get 'users/sign_up' => 'registrations#new', as: :new_user_registration
    post 'users' => 'registrations#create', as: :user_registration
    get 'users/password/new' => 'passwords#new', as: :new_user_password
  end

  root :to => 'welcome#index'
end
