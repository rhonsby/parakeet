Parakeet::Application.routes.draw do
  root "pages#root"

  namespace :api, defaults: { format: 'json' } do
    get 'users/:username' => 'users#show'
    get 'mutual_follows' => 'follows#mutual_follows'
  end
end
