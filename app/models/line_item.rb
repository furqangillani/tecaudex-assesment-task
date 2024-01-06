class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :quantity, presence: true

  def get_line_item_price
    self.product.price.to_f
  end

  def get_product_details
    product = self.product
    {
      line_item_id: self.id,
      product_id: product.id,
      product_title: product.title,
      product_price: product.price.to_f,
      product_description: product.description,
      categories: product.categories&.pluck(:id,:title)
    }
  end

  def get_vendor_details
    self.product.vendor
  end
  
end
