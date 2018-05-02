# frozen_string_literal: true

class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.text :body
      t.integer :question_id

      t.timestamps
    end
    add_index :answers, :question_id
  end
end
