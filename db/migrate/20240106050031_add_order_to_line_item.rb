class AddOrderToLineItem < ActiveRecord::Migration[7.1]
  def change
    add_reference :line_items, :order, null: false, foreign_key: true
  end
end
