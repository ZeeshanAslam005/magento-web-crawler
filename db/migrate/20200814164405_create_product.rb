class CreateProduct < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :href
      t.boolean :visited, default: false
      t.string :name
      t.string :price
      t.string :details
      t.string :extra_information
    end
    add_index :products, :href
  end
end
