class AddLineToPosts < ActiveRecord::Migration[5.0]
  def change
    add_reference :posts, :line, foreign_key: true
  end
end
