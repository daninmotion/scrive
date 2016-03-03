Rails.application.routes.draw do
  resources :pages

  root 'pages#index'

  get '/landing', to: 'application#landing'
end
