Rails.application.routes.draw do
  devise_for :users
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

  resources :questions, concerns: :votable do
    # resources :comments, only: :create
    resources :answers, concerns: :votable, shallow: true do
      # resources :comments, only: :create
      member do
        post :choose_best
      end
    end
  end

  mount ActionCable.server => '/cable'
end
