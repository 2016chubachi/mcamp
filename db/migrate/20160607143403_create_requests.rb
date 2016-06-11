class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :loan_item_id
      t.integer :user_id
      t.text :message
      t.integer :message_state_id
      t.boolean :delete_flg

      t.timestamps null: false
    end
  end
end
