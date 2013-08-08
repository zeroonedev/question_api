QuestionServer::Application.routes.draw do

  devise_for :admins
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  devise_for :users, :controllers => { sessions: 'sessions' }
  match 'users/sign_in' => 'cors#options', constraints: { method: 'OPTIONS' }

  resources :questions
  resources :episodes
  resources :form_metadatum

  match 'questions.json' => 'cors#options', constraints: { method: 'OPTIONS' }
  match 'questions/:id.json' => 'cors#options', constraints: { method: 'OPTIONS' }

  match 'episodes.json' => 'cors#options', constraints: { method: 'OPTIONS' }
  match 'episodes/:id.json' => 'cors#options', constraints: { method: 'OPTIONS' }

  match 'form_metadatum.json' => 'cors#options', constraints: { method: 'OPTIONS' }
  match 'form_metadatum/:id.json' => 'cors#options', constraints: { method: 'OPTIONS' }

  root :to => "client#index"

end
