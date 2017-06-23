Rails.application.routes.draw do
  get 'main/index'

  get 'dashboard/index'

  post 'dashboard/update_project' => 'dashboard#update'

  get 'handout/index'

  get 'handout' => 'handout#show'

  post 'handout/graph_link' => 'handout#graph_link'

  root 'main#index'

  resources :employees

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
