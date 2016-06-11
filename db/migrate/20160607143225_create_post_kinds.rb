class CreatePostKinds < ActiveRecord::Migration
  def change
    create_table :post_kinds do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
