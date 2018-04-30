FactoryBot.define do
  factory :question do
    title "MyString"
    body "MyText"
    user
  end

  factory :invalid_question, class: "Question" do
    title nil
    body nil
    user
  end

  factory :new_question, class: "Question" do
    title 'new'
    body 'new'
    user
  end
end
