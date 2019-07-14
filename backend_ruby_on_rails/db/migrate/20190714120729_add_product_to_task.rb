class AddProductToTask < ActiveRecord::Migration[6.0]
  def change
    add_reference :tasks, :product, null: false, foreign_key: true
    add_reference :tasks, :worker, null: false, foreign_key: true
  end
end
