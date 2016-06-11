class CreatePostReplyImages < ActiveRecord::Migration
  def change
    create_table :post_reply_images do |t|
      t.integer :post_reply_id
      t.binary :image
      t.integer :post_kind_id

      t.timestamps null: false
    end
  end
end
