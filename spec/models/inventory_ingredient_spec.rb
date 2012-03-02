require 'spec_helper'

describe InventoryIngredient do

  before do
    @ingredient = Ingredient.create! name: "foo", cost: 1.0
  end

  it 'can be saved' do
    InventoryIngredient.
      create!(units: 1.0, ingredient: @ingredient).
        should be_persisted
  end

  it_raises_error 'disallows no association with ingredient' do
    InventoryIngredient.create! units: 5.0
  end

  it_raises_error 'disallows units less than 0' do
    InventoryIngredient.create! units: -1.0, ingredient: @ingredient
  end

  it_raises_error "disallows units greater than #{InventoryIngredient::MAX_UNITS}" do
    InventoryIngredient.create! units: InventoryIngredient::MAX_UNITS+1, ingredient: @ingredient
  end

end
