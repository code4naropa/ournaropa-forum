OurnaropaForum::Engine.routes.draw do
  
  
  # Subscriptions Controller
  get 'conversation/:conversation_id/subscribe', to: 'subscriptions#subscribe', as: 'subscribe'
  get 'conversation/:conversation_id/unsubscribe', to: 'subscriptions#unsubscribe', as: 'unsubscribe'

  # Passwords Controller
  get 'passwords/forgot', to: 'passwords#forgot', as: 'forgot_password'
  match 'passwords/reset', to: 'passwords#reset', via: :post, as: 'reset_password'
  get ':id/reset-password/:reset_token', to: 'passwords#new_after_reset', as: 'new_password_after_reset'
  match ':id/reset-password/:reset_token', to: 'passwords#update_after_reset', via: :post, as: 'update_password_after_reset'
  get 'change-password', to: 'passwords#new', as: 'new_password'
  match 'change-password', to: 'passwords#update', via: :post, as: 'update_password'  
  
  # Users Controller
  get '/directory', to: 'users#index', as: 'directory'

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
