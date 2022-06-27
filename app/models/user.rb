class User < ApplicationRecord
  RESULT_PER_PAGE = 10 
  ## Associations
  has_many :user_preferred_brands, dependent: :destroy
  has_many :preferred_brands, through: :user_preferred_brands, source: :brand
end
