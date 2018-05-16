# frozen_string_literal: true

FactoryBot.define do
  sequence(:email) { |n| "test#{n}@example.com" }
  sequence(:nickname) { |n| "test#{n}" }

  factory :user do
    email
    nickname
    password 'password'
  end

  factory :new_user do
    email
    nickname
    password 'password'
  end
end
