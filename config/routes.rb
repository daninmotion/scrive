Rails.application.routes.draw do

  devise_for :users
  resources :pages do 
    collection do
      get :autocomplete
    end
  end

  resources :subscribe
  resource :subscription

  root 'pages#index'

  get '/landing', to: 'application#landing'
end
