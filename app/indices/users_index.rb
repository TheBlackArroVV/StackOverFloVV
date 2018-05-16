ThinkingSphinx::Index.define :user, with: :active_record do
  # fields
  indexes nickname, sortable: true
end