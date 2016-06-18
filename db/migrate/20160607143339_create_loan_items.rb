class CreateLoanItems < ActiveRecord::Migration
  def change
    create_table :loan_items do |t|
      t.string :item_name
      t.integer :member_id
      t.integer :category_id
      t.text :item_description
      t.integer :fare, default: 0
      t.text :term
      t.text :location
      t.integer :loan_state_id
      t.boolean :delete_flg, default: false

      t.timestamps null: false
    end
  end
end
