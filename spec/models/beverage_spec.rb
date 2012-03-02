require 'spec_helper'

describe Beverage do
 
  it 'can be saved' do
    Beverage.create!(
      name: 'coffee'
    ).should be_persisted
  end

  it '#as_json' do
    bev = Beverage.create(name: 'coffee')
    bev.ingredients.build units: 5, ingredient: Ingredient.create!(name: "foo", cost: 1.0)
    bev.ingredients.build units: 6, ingredient: Ingredient.create!(name: "foo2", cost: 2.0)
    bev.save
    bev.as_json.should == {
      'id' => bev.id,
      'name' => bev.name,
      ingredients: bev.ingredients.as_json
    }
  end

  it 'can have ingredients' do
    ingredient1 = Ingredient.create! name: "foo", cost: 1.0
    ingredient2 = Ingredient.create! name: "foo2", cost: 2.0

    bev = Beverage.create(name: 'coffee')
    bev.ingredients.build units: 5, ingredient: ingredient1
    bev.ingredients.build units: 6, ingredient: ingredient2
    bev.save
    bev.should be_persisted

    Beverage.find_by_name('coffee').ingredients.all.map do |i| 
      {units: i.units, ingredient: {name: i.ingredient.name, cost: i.ingredient.cost.to_f} }
    end.should == [
      {units: 5, ingredient: {name: ingredient1.name, cost: ingredient1.cost.to_f}},
      {units: 6, ingredient: {name: ingredient2.name, cost: ingredient2.cost.to_f}}
    ]
  end

  it_raises_error "disallows no name" do
    Beverage.create!
  end

  it_raises_error "disallows name less than 2 characters" do
    Beverage.create! name: "1"
  end

  it "disallows duplicate named beverages" do
    Beverage.create! name: "coffee"
    expect {
      Beverage.create! name: "coffee"
    }.to raise_error
  end

end
