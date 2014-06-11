Parakeet::Application.routes.draw do
  root "pages#root"

  namespace :api, defaults: { format: 'json' } do
    resources :users, only: [:index, :create]
    get 'users/:username' => 'users#show'
  end
end
