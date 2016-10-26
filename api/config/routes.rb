Rails.application.routes.draw do
  mount Facebook::Messenger::Server, at: 'bot'

  get :businesses, to: 'businesses#index'
  post :businesses, to: 'businesses#submit'
  get :search, to: 'search#index'
end
