QuestionServer::Application.routes.draw do

  devise_for :admins
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  devise_for :users, :controllers => { sessions: 'sessions' }

  resources :questions
  resources :episodes
  resources :form_metadatum

  root :to => "client#index"

  # Note: Middleware is setting the OPTIONS CORS response headers
  %w( users/sign_in
      users/sign_out
      questions.json
      questions/:id.json
      episodes.json
      episodes/:id.json ).each do |path|
    match path => 'cors#options', constraints: { method: 'OPTIONS' }
  end
end
