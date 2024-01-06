class CreateProduct < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.decimal :price
      t.references :vendor, null: false, foreign_key: true

      t.timestamps
    end
  end
end
