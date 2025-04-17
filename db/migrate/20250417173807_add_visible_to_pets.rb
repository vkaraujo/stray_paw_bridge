class AddVisibleToPets < ActiveRecord::Migration[7.1]
  def change
    add_column :pets, :visible, :boolean, default: true, null: false
  end
end
