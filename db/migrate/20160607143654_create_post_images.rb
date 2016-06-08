class CreatePostImages < ActiveRecord::Migration
  def change
    create_table :post_images do |t|
      t.integer :post_id
      t.binary :image
      t.integer :posttype_id

      t.timestamps null: false
    end
  end
end
