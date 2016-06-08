class CreateAuthorities < ActiveRecord::Migration
  def change
    create_table :authorities do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
