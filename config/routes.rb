Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
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
    resources :answers, concerns: :votable, shallow: true do
      member do
        post :choose_best
      end
    end
  end

  mount ActionCable.server => '/cable'
end
