QuestionServer::Application.routes.draw do

  devise_for :admins
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  devise_for :users, :controllers => { sessions: 'sessions' } do
    match '/users/info' => 'sessions#info'
  end

  match '/episodes/replace_question' => 'episodes#replace_question'
  match '/episodes/:id/export_csv'   => 'episodes#export_csv'

  resources :episodes
  resources :form_metadatum
  resources :questions

  root :to => "client#index"

  # Note: Middleware is setting the OPTIONS CORS response headers
  %w( users/sign_in
      users/sign_out
      users/info
      questions.json
      questions/:id.json
      episodes/:id/export_csv
      episodes.json
      episodes/:id.json
      episodes/replace_question
      episodes/replace_question.json
      ).each do |path|
    match path => 'cors#options', constraints: { method: 'OPTIONS' }
  end
end
