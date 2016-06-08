class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.integer :user_id
      t.integer :poststate_id
      t.boolean :delete_flg
      t.integer :posttype_id

      t.timestamps null: false
    end
  end
end
