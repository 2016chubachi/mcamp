class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.string :title
      t.text :description
      t.string :link
      t.integer :aduser_id

      t.timestamps null: false
    end
  end
end
