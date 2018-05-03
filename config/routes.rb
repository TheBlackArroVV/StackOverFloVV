# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'questions#index'

  concern :votable do
    member do
      post :like
      post :dislike
      delete :unvote
    end
  end

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
