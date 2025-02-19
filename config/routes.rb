Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations' }
  root to: 'questions#index'

  concern :votable do
    member do
      post :like
      post :dislike
      delete :unvote
    end
  end
  resources :comments, only: :create

  resources :attachments, shallow: true

  resources :user_mails, shallow: true

  resources :questions, concerns: :votable do
    resources :answers, concerns: :votable, shallow: true do
      member do
        post :choose_best
      end
    end
  end

  mount ActionCable.server => '/cable'

  namespace :api do
    namespace :v1 do
      resource :profiles do
        get :me, on: :collection
        get :users
      end
      resources :questions
      resources :answers
    end
  end

  get '/search', to: 'search#index', format: :json
  post '/search', to: 'search#index', format: :json
end
