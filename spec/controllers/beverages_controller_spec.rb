require 'spec_helper'

describe BeveragesController do
  # describe 'GET index JSON' do
  #   before do
  #     get :index, :format => :json
  #     @beverages = JSON.parse response.body
  #   end
  # end

  before do
    
    Ingredient.create([
      { name: 'Espresso', cost: 1.10 },
      { name: 'Coffee', cost: 0.75 },
      { name: 'Sugar', cost: 0.25 },
      { name: 'Cream', cost: 0.25 },
    ])
    Ingredient.all.map do |ii|
      InventoryIngredient.create!( units: InventoryIngredient::MAX_UNITS, ingredient: ii )
    end

    Beverage.create!( name: 'Cafe Americano' ).
      ingredients.create!( units: 3, ingredient: Ingredient.find_by_name('Espresso') )

    Beverage.create( name: 'Coffee' ).
      ingredients.create([
        { units: 3, ingredient: Ingredient.find_by_name('Coffee')},
        { units: 1, ingredient: Ingredient.find_by_name('Sugar')},
        { units: 1, ingredient: Ingredient.find_by_name('Cream')}
      ]);
  end

  it 'renders index' do
    get :index, :format => :json
    response.should be_success
    response.body.should == [
      { id: 1,
        name: 'Cafe Americano',
        ingredients: [{
          id: 1,
          name: 'Espresso',
          cost: 1.1,
          units: 3
        }]
      },
      { id: 2,
        name: 'Coffee',
        ingredients: [
          { id: 2,
            name: 'Coffee',
            cost: 0.75,
            units: 3
          },
          { id: 3,
            name: 'Sugar',
            cost: 0.25,
            units: 1
          },
          { id: 4,
            name: 'Cream',
            cost: 0.25,
            units: 1
          }
        ]
      }
    ].to_json
  end

  it 'renders show' do
    get :show, :format => :json, :id => 1
    response.should be_success
    response.body.should == {
      id: 1,
      name: 'Cafe Americano',
      ingredients: [{
        id: 1,
        name: 'Espresso',
        cost: 1.1,
        units: 3
      }]
    }.to_json
  end


  it 'renders show, bad id' do
    get :show, :format => :json, :id => 77
    response.should be_success
    response.body.should == {}.to_json
  end

end
