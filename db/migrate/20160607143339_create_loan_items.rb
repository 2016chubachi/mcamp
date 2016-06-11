class CreateLoanItems < ActiveRecord::Migration
  def change
    create_table :loan_items do |t|
      t.string :item_name
      t.integer :user_id
      t.integer :category_id
      t.text :item_description
      t.integer :fare
      t.text :term
      t.text :location
      t.integer :loan_state_id
      t.boolean :delete_flg

      t.timestamps null: false
    end
  end
end
