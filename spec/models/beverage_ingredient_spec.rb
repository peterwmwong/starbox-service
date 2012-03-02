require 'spec_helper'

describe BeverageIngredient do

  before do
    @ingredient = Ingredient.create! name: "foo", cost: 1.0
    @beverage = Beverage.create! name: "bar"
  end

  describe 'on successful creation' do
    
    before do
      @beverage_ingredient = BeverageIngredient.create!(
        units: 5,
        ingredient: @ingredient,
        beverage: @beverage
      )
    end

    it 'can be saved' do
      @beverage_ingredient.should be_persisted
    end

    it 'delegates .name' do
      @beverage_ingredient.name.should == @beverage_ingredient.ingredient.name
    end

    it 'delegates .cost' do
      @beverage_ingredient.cost.should == @beverage_ingredient.ingredient.cost
    end

  end
  it_raises_error 'disallows units less than 0' do
    BeverageIngredient.create!(
      units: -1,
      ingredient: @ingredient,
      beverage: @beverage
    )
  end

  describe 'validates associations' do

    it_raises_error 'disallows no association with ingredient' do
      BeverageIngredient.create! units: 5, beverage: @beverage
    end

    it_raises_error 'disallows no association with beverage' do
      BeverageIngredient.create! units: 5, ingredient: @ingredient
    end

    it_raises_error 'disallows no association with beverage or ingredient' do
      BeverageIngredient.create! units: 5
    end

    it 'disallows duplicate association with beverage and ingredient' do
      BeverageIngredient.create!(
        units: 5,
        ingredient: @ingredient,
        beverage: @beverage
      )
      expect {
        BeverageIngredient.create!(
          units: 6,
          ingredient: @ingredient,
          beverage: @beverage
        )
      }.to raise_error
    end

  end

  it '#as_json' do
    @beverage_ingredient = BeverageIngredient.create!(
      units: 5,
      ingredient: @ingredient,
      beverage: @beverage
    )
    @beverage_ingredient.as_json.should == {
      'id' => @beverage_ingredient.id,
      'name' => @beverage_ingredient.name,
      'cost' => @beverage_ingredient.cost.to_f,
      'units' => @beverage_ingredient.units
    }
  end

end
