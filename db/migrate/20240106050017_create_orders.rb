class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.string :order_number
      t.decimal :total
      t.decimal :tax
      t.decimal :delivery_charges

      t.timestamps
    end
  end
end
