class CreateLoanItemImages < ActiveRecord::Migration
  def change
    create_table :loan_item_images do |t|
      t.integer :loanitem_id
      t.binary :image

      t.timestamps null: false
    end
  end
end
