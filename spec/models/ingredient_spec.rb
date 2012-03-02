require 'spec_helper'

describe Ingredient do

  it 'can be saved' do
    Ingredient.create!(name: "foo", cost: 1.0).
      should be_persisted
  end

  it_raises_error 'disallows cost less then 0' do
    Ingredient.create! name: 'test', cost: -1.0
  end

  it_raises_error 'disallows empty name' do
    Ingredient.create! cost: 2
  end

  it_raises_error 'disallows name less than 2 characters' do
    Ingredient.create! name: '1', cost: 2
  end

  it "disallows duplicate named ingredients" do
    Ingredient.create! name: 'sugar', cost: 2
    expect {
      Ingredient.create! name: 'sugar', cost: 2
    }.to raise_error
  end

end

