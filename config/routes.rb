Rails.application.routes.draw do
  get 'messages/create'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "chatrooms#index"
  resources :chatrooms, only: :show do
    resources :messages, only: :create
  end
end
