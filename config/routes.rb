Rails.application.routes.draw do
  devise_for :users
  resources :pages
  resource :subscription

  root 'pages#index'

  get '/landing', to: 'application#landing'
end
