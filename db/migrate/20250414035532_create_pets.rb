class CreatePets < ActiveRecord::Migration[7.1]
  def change
    create_table :pets do |t|
      t.string :name
      t.text :description
      t.integer :species
      t.integer :age
      t.string :size
      t.integer :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
