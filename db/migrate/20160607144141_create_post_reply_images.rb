class CreatePostReplyImages < ActiveRecord::Migration
  def change
    create_table :post_reply_images do |t|
      t.integer :postreply_id
      t.binary :image
      t.integer :posttype_id

      t.timestamps null: false
    end
  end
end
