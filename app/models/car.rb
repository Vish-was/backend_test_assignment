class Car < ApplicationRecord
  ## Associations
  belongs_to :brand

  ## Scopes
  scope :filter_by_model, ->(name: ''){ where("brands.name = ? ", name) unless name.blank? }
  scope :filter_by_price, ->(min, max){ where("cars.price BETWEEN ? AND ? ", min, max) }
end
