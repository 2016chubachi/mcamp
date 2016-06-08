class CreateBorrowStates < ActiveRecord::Migration
  def change
    create_table :borrow_states do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
