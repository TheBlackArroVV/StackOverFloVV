ThinkingSphinx::Index.define :answer, with: :active_record do
  # fields
  indexes body
  indexes user.nickname, as: :author, sortable: true

  # attributes
  has user_id
  has question_id, created_at, updated_at
end