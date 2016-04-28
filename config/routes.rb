OurnaropaForum::Engine.routes.draw do
  resources :conversations do
    resources :replies
  end
  
  root :to => "conversations#index"
end
