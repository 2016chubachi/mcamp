class CreateMessageStates < ActiveRecord::Migration
  def change
    create_table :message_states do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
