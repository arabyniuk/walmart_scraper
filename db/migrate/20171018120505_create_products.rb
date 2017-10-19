class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.float :price

      t.timestamps
    end

    create_table :reviews do |t|
      t.string :title
      t.text :body
      t.integer :product_id

      t.timestamps
    end
  end
end
