class CreateInfos < ActiveRecord::Migration
  def change
    create_table :infos do |t|
      t.integer :user_id
      t.string :brand
      t.text :product_name
      t.string :product_price
      t.string :product_img
      t.string :product_url
      
      t.timestamps null: false
    end
  end
end
