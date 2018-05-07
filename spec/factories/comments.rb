FactoryBot.define do
  factory :comment do
    body "Comment"
    commentable_type 1
    commentable_id ""
  end

  factory :invalid_comment, class: 'Comment' do
    body ''
    commentable_type ''
    commentable_id ''
  end
end
