Rails.application.routes.draw do
  resources :users
  post '/auth/login', to: 'auth#login'
  resources :tasks
  get '/completed_tasks', to: 'tasks#completed'
  get '/uncompleted_tasks', to: 'tasks#uncompleted'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
