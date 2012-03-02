class CreateBeverageIngredients < ActiveRecord::Migration
  def change
    create_table :beverage_ingredients do |t|
      t.integer :units
      t.references :ingredient
      t.references :beverage

      t.timestamps
    end
    add_index :beverage_ingredients, :ingredient_id
    add_index :beverage_ingredients, :beverage_id
  end
end
