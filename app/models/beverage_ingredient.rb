class BeverageIngredient < ActiveRecord::Base
  belongs_to :ingredient
  belongs_to :beverage

  delegate :name, :cost, :to => :ingredient
  
  validates :ingredient, :beverage, presence: true
  validates :units, numericality: { greater_than_or_equal_to: 0 }
  validates :ingredient_id, uniqueness: {scope: :beverage_id}


  def as_json(options={})
    { 'id' => id,
      'name' => name,
      'cost' => cost.to_f,
      'units' => units
    }
  end

end
