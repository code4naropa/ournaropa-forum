OurnaropaForum::Engine.routes.draw do
  
  get 'profile/edit'

  get 'profile/update'

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
  
  # Manage Access
  get '/manage-access', to: 'permitted_users#index', as: 'manage_access'
  resources :permitted_users, only: [:index, :new, :create, :destroy], path: '/manage-access'

  # Edit User Profile
  get '/profile', to: 'profile#edit', as: 'profile'
  match '/profile', to: 'profile#update', as: 'update_profile', via: [:patch, :put]
  
  get '/conversation/:id/reply', to: 'conversations#show'
  resources :conversations, path: '/conversation', only: [:show, :new, :create] do
    resources :replies, path: '/reply', only: [:create]
  end
  
  root :to => "home#welcome"
end
