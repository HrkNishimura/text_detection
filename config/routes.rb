Rails.application.routes.draw do
  root 'posts#index'
  resources :posts, only: %i[index create]
end
