class Ingredient < ActiveRecord::Base
  has_many :beverage_ingredients
  has_many :inventory_ingredients
  
  validates :cost, numericality: { greater_than_or_equal_to: 0.0 }
  validates :name, {
    length: { minimum: 2 },
    uniqueness: true
  }
end
