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
      t.string :password_digest
      t.string :remember_digest
      t.string :activation_digest
      t.boolean :activated, default:false
      t.datetime :activated_at
      t.string :reset_digest
      t.datetime :reset_sent_at
      t.boolean :admin, default:false

      t.timestamps null: false
    end
  end
end
