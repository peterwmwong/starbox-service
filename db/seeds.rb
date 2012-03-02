# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Ingredient.create([
  { name: 'Cocoa', cost: 0.90 },
  { name: 'Coffee', cost: 0.75 },
  { name: 'Cream', cost: 0.25 },
  { name: 'Decaf Coffee', cost: 0.75 },
  { name: 'Espresso', cost: 1.10 },
  { name: 'Foamed Milk', cost: 0.35 },
  { name: 'Steamed Milk', cost: 0.35 },
  { name: 'Sugar', cost: 0.25 },
  { name: 'Whipped Cream', cost: 1.00 }
])

Ingredient.all.map do |ii|
  InventoryIngredient.create!( units: InventoryIngredient::MAX_UNITS, ingredient: ii )
end

Beverage.create( name: 'Cafe Americano' ).
  ingredients.create([
    { units: 3, ingredient: Ingredient.find_by_name('Espresso')}
  ])

Beverage.create( name: 'Cafe Latte' ).
  ingredients.create([
    { units: 2, ingredient: Ingredient.find_by_name('Espresso')},
    { units: 1, ingredient: Ingredient.find_by_name('Steamed Milk')}
  ])

Beverage.create( name: 'Cafe Mocha' ).
  ingredients.create([
    { units: 1, ingredient: Ingredient.find_by_name('Espresso')},
    { units: 1, ingredient: Ingredient.find_by_name('Cocoa')},
    { units: 1, ingredient: Ingredient.find_by_name('Steamed Milk')},
    { units: 1, ingredient: Ingredient.find_by_name('Whipped Cream')}
  ]);

Beverage.create( name: 'Cappuccino' ).
  ingredients.create([
    { units: 2, ingredient: Ingredient.find_by_name('Espresso')},
    { units: 1, ingredient: Ingredient.find_by_name('Steamed Milk')},
    { units: 1, ingredient: Ingredient.find_by_name('Foamed Milk')}
  ]);

Beverage.create( name: 'Coffee' ).
  ingredients.create([
    { units: 3, ingredient: Ingredient.find_by_name('Coffee')},
    { units: 1, ingredient: Ingredient.find_by_name('Sugar')},
    { units: 1, ingredient: Ingredient.find_by_name('Cream')}
  ]);

Beverage.create( name: 'Decaf Coffee' ).
  ingredients.create([
    { units: 3, ingredient: Ingredient.find_by_name('Decaf Coffee')},
    { units: 1, ingredient: Ingredient.find_by_name('Sugar')},
    { units: 1, ingredient: Ingredient.find_by_name('Cream')}
  ]);

