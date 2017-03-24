Rails.application.routes.draw do
  get 'handout/index' 

  get 'handout' => 'handout#show'
  
  post 'handout/graph_link' => 'handout#graph_link'

  root 'handout#index'

  resources :employees

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
