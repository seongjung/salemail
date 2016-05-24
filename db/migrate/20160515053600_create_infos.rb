class CreateInfos < ActiveRecord::Migration
  def change
    create_table :infos do |t|
      t.integer :user_id        #userId
      t.string :brand           #brand
      t.text :product_name      #제품 이름
      t.string :product_price   #제품 가격1
      t.string :product_img     #제품 사진
      t.string :product_url     #제품 주소
      t.string :product_code    #제품 xpath 코드
      t.string :sale_price      #제품 가격2
      
      t.timestamps null: false
    end
  end
end
