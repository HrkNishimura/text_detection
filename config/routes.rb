Rails.application.routes.draw do
  root 'posts#index'
  resources :posts, only: %i[index create]
  get '/result', to: 'posts#result'
  post '/result', to: 'posts#result'
end
