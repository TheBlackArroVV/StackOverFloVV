FactoryBot.define do
  factory :answer do
    body "MyAnswer"
    question
    user
  end

  factory :new_answer do
    body "MyText"
    question
    user
  end

  factory :invalid_answer, class: 'Answer' do
    body nil
    question nil
    user nil
  end
end
