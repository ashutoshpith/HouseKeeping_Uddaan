class RemoveTaskFromProduct < ActiveRecord::Migration[6.0]
  def change

    remove_column :products, :task_id, :refernces
  end
end
