class Beverage < ActiveRecord::Base
  has_many :ingredients, :class_name => "BeverageIngredient"

  validates :name, {
    length: { :minimum => 2 },
    uniqueness: true
  }

  def as_json(options={})
    { "id" => id,
      "name" => name,
      :ingredients => ingredients.map(&:as_json)
    }
  end

  class << self
    def all_for_json
      includes({
        :ingredients => [
          :ingredient
        ]
      })
    end
  end
end
