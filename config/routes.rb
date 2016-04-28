OurnaropaForum::Engine.routes.draw do
  resources :replies
  resources :conversations
  
  root :to => "conversations#index"
end
