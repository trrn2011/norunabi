class CreateFollows < ActiveRecord::Migration[5.0]
  def change
    create_table :follows do |t|
      t.references :user, foreign_key: true
      t.references :line, foreign_key: true

      t.timestamps
      
      t.index [:user_id, :line_id], unique: true
    end
  end
end
