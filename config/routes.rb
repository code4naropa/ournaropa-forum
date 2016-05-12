OurnaropaForum::Engine.routes.draw do
  
  resources :permitted_users, only: [:index, :new, :create, :destroy]
  # Registrations Controller
  get 'signup', to: 'registrations#new'
  get 'verification', to: redirect("/forum/signup")
  match 'verification', to: 'registrations#verify', via: :post, as: 'verify_email'
  match 'signup', to: 'registrations#create', via: :post

  resources :users
  
  resources :conversations do
    resources :replies
  end
  
  root :to => "conversations#index"
end
