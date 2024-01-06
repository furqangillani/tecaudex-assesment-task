class Product < ApplicationRecord
  belongs_to :vendor
  has_many :product_categories
  has_many :categories, through: :product_categories


  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :vendor_id, presence: true

end
