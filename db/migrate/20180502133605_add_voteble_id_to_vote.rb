class AddVotebleIdToVote < ActiveRecord::Migration[5.2]
  def change
    add_column :votes, :votable_id, :integer
    add_column :votes, :votable_type, :string

    add_index :votes, %i[votable_id votable_type]
  end
end
