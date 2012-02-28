Stock
  has_many :ingredients, :as => :uses_ingredient

Beverage
  name:string
  has_many :ingredient, :as => :uses_ingredient

Ingredient
  units:int
  has_one IngredientInfo
  belongs_to :uses_ingredient, :polymorphic => true
    :uses_ingredient:references :polymorphic => true

IngredientInfo
  name:string
  cost:number
  belongs_to Ingredient

