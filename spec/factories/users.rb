# frozen_string_literal: true

FactoryBot.define do
  sequence(:email) { |n| "test#{n}@example.com" }

  factory :user do
    email
    password 'password'
  end

  factory :new_user do
    email
    password 'password'
  end
end
