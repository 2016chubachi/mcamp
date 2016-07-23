class CreateSubmitTokens < ActiveRecord::Migration
  def change
    #create_table :submit_tokens,{id:false,primary_key: :token_id} do |t|
    create_table :submit_tokens,{id: false} do |t|
      t.string :token_id,primary_key: true

      t.timestamps null: false
    end
  end
end
