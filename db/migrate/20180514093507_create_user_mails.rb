class CreateUserMails < ActiveRecord::Migration[5.2]
  def change
    create_table :user_mails do |t|
      t.integer :question_id
      t.integer :user_id

      t.timestamps
    end
    add_index :user_mails, [:question_id, :user_id]
  end
end
