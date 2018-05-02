FactoryBot.define do
  factory :question do
    title "MyString"
    body "MyText"
  end

  factory :invalid_question, class: "Question" do
    title nil
    body nil
  end

  factory :new_question, class: "Question" do
    title 'new'
    body 'new'
  end
end
