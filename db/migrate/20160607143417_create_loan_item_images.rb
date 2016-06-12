class CreateLoanItemImages < ActiveRecord::Migration
  def change
    create_table :loan_item_images do |t|
      t.integer :loan_item_id
      t.binary :image
      t.string :content_type
      
      t.timestamps null: false
    end
  end
end
