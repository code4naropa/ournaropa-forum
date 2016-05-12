OurnaropaForum::Engine.routes.draw do
  
  get 'home/welcome'

  # Sessions Controller
  get 'login', to: 'sessions#new', as: 'login'
  match 'login', to: 'sessions#create', via: :post, as: 'attempt_login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
    
  # Registrations Controller
  get 'signup', to: 'registrations#new'
  get 'verification', to: redirect("/forum/signup")
  match 'verification', to: 'registrations#verify', via: :post, as: 'verify_email'
  match 'signup', to: 'registrations#create', via: :post

  resources :permitted_users, only: [:index, :new, :create, :destroy]

  resources :users, only: [:edit, :update]
  
  resources :conversations do
    resources :replies
  end
  
  root :to => "home#welcome"
end
