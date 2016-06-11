class CreateBorrowItems < ActiveRecord::Migration
  def change
    create_table :borrow_items do |t|
      t.string :item_name
      t.integer :user_id
      t.integer :category_id
      t.text :item_description
      t.integer :fare
      t.text :term
      t.string :location
      t.integer :borrow_state_id
      t.boolean :delete_flg

      t.timestamps null: false
    end
  end
end
