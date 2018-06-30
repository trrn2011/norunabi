class CreateLines < ActiveRecord::Migration[5.0]
  def change
    create_table :lines do |t|
      t.string :name
      t.integer :line_cd
      t.string :side

      t.timestamps
    end
  end
end
