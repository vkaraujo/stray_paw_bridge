class CreateAdoptionRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :adoption_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :pet, null: false, foreign_key: true
      t.text :message
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
