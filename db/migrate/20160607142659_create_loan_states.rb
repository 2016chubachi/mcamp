class CreateLoanStates < ActiveRecord::Migration
  def change
    create_table :loan_states do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
