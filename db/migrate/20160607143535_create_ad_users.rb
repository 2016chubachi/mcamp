class CreateAdUsers < ActiveRecord::Migration
  def change
    create_table :ad_users do |t|
      t.string :company
      t.string :email
      t.string :password
      t.integer :authority_id
      t.integer :point
      t.integer :business_id
      t.string :user_name
      t.binary :avator

      t.timestamps null: false
    end
  end
end
