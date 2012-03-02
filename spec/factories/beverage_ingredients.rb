# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :beverage_ingredient do
    units 1
    ingredient_info nil
    beverage nil
  end
end
