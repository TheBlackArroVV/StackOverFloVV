require 'rails_helper'

RSpec.describe Vote, type: :model do
  it { should belong_to :votable }
  it { should belong_to :user }

  it { should validate_presence_of :score }
  it { should validate_uniqueness_of(:score).scoped_to(:votable_id, :votable_type, :user_id) }
end
