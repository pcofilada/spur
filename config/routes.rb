Rails.application.routes.draw do
  mount Facebook::Messenger::Server, at: 'bot'

  get :businesses, to: 'businesses#index'
  post :businesses, to: 'businesses#submit'
end
