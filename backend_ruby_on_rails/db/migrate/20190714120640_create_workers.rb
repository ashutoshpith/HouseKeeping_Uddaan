class CreateWorkers < ActiveRecord::Migration[6.0]
  def change
    create_table :workers do |t|
      t.string :name
      t.string :skill_set
      t.references :admin, null: false, foreign_key: true

      t.timestamps
    end
  end
end
