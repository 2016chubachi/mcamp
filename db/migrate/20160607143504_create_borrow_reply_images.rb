class CreateBorrowReplyImages < ActiveRecord::Migration
  def change
    create_table :borrow_reply_images do |t|
      t.integer :borrow_reply_id
      t.binary :image

      t.timestamps null: false
    end
  end
end
