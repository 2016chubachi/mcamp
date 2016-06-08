class CreateQuestionDetails < ActiveRecord::Migration
  def change
    create_table :question_details do |t|
      t.integer :question_id
      t.string :question
      t.text :answer
      t.text :description

      t.timestamps null: false
    end
  end
end
