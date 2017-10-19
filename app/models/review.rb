class Review < ApplicationRecord
  belongs_to :product

  validates_uniqueness_of :body, scope: :product_id
end
