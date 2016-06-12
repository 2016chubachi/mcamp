class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.integer :member_id
      t.integer :post_state_id
      t.boolean :delete_flg
      t.integer :post_kind_id

      t.timestamps null: false
    end
  end
end
