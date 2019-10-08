class CreateCharges < ActiveRecord::Migration[5.2]
  def change
    create_table :charges do |t|
      t.integer :user_id
      t.float :price
      t.text :items, array: true, default: []
      t.timestamps
    end
  end
end
