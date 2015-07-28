Rails.application.routes.draw do

  root 'cards#index'
  
  get 'cards/new/(:id)', to: 'cards#new', as: :new_card
  get 'cards/category/(:category)', to: 'cards#index', as: :card_category
  resources :cards
  resources :users

  get 'auth/:service/callback', to: 'external_authentications#create'
  get 'auth/failure', to: 'external_authentications#failure'
  post   'sessions'  => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  resources :external_authentications, only: [:index, :edit, :update, :destroy]
  resources :password_resets, only: [:create, :edit, :update]

  if Rails.env.development?
    # root 'pages#index'
    get '/sandbox' => 'sandbox#index'
    get '/sandbox/*template' => 'sandbox#show'
  end

end
