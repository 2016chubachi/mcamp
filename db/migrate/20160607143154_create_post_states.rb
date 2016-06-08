class CreatePostStates < ActiveRecord::Migration
  def change
    create_table :post_states do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
