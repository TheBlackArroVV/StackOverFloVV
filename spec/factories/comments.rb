FactoryBot.define do
  factory :comment do
    body "MyString"
    commentable_type 1
    commentable_id ""
  end

  factory :invalid_comment do
    body ''
    commentable_type ''
    commentable_id ''
  end
end
