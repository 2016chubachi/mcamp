class CreatePostReplies < ActiveRecord::Migration
  def change
    create_table :post_replies do |t|
      t.integer :post_id
      t.string :title
      t.text :content
      t.integer :member_id
      t.boolean :delete_flg

      t.timestamps null: false
    end
  end
end
