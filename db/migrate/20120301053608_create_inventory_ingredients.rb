class CreateInventoryIngredients < ActiveRecord::Migration
  def change
    create_table :inventory_ingredients do |t|
      t.integer :units
      t.references :ingredient

      t.timestamps
    end
    add_index :inventory_ingredients, :ingredient_id
  end
end
