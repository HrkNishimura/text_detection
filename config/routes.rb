Rails.application.routes.draw do
  root 'posts#index'
  resources :posts, only: %i[index create]
  post '/result', to: 'posts#result'
end
