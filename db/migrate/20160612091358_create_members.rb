class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :name
      t.string :email
      t.string :password
      t.integer :authority_id
      t.integer :point
      t.integer :gender
      t.string :self_introduction
      t.integer :generation_id
      t.string :user_name
      t.binary :avator

      t.timestamps null: false
    end
  end
end
