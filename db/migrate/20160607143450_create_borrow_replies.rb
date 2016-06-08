class CreateBorrowReplies < ActiveRecord::Migration
  def change
    create_table :borrow_replies do |t|
      t.integer :borrowitem_id
      t.integer :user_id
      t.text :message
      t.integer :messagestate_id
      t.boolean :delete_flg

      t.timestamps null: false
    end
  end
end
