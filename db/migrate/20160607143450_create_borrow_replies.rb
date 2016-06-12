class CreateBorrowReplies < ActiveRecord::Migration
  def change
    create_table :borrow_replies do |t|
      t.integer :borrow_item_id
      t.integer :member_id
      t.text :message
      t.integer :message_state_id
      t.boolean :delete_flg

      t.timestamps null: false
    end
  end
end
