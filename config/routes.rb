Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get '/projects/:id', to: 'projects#show'
  post '/projects/:id', to: 'contestantprojects#create'

  get '/contestants', to: 'contestants#index'
end
