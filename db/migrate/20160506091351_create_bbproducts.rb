class CreateBbproducts < ActiveRecord::Migration
  def change
    create_table :bbproducts do |t|
      t.string  :pname
      t.integer :price
      t.timestamps null: false
    end
  end
end
