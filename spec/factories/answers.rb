# frozen_string_literal: true

FactoryBot.define do
  factory :answer do
    body 'MyAnswer'
    best_answer false
    question
    user
  end

  factory :new_answer do
    body 'new'
    best_answer false
    question
    user
  end

  factory :best_answer do
    body 'best_answer'
    best_answer true
    question
    user
  end

  factory :invalid_answer, class: 'Answer' do
    body nil
    question nil
    best_answer false
    user nil
  end
end
