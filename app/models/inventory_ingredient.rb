class InventoryIngredient < ActiveRecord::Base
  MAX_UNITS = 25
  
  belongs_to :ingredient

  delegate :name, :cost, :to => :ingredient
  
  validates :units, numericality: {
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: MAX_UNITS,
  }
  validates :ingredient_id, presence: true
end
