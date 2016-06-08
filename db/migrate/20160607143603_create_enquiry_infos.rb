class CreateEnquiryInfos < ActiveRecord::Migration
  def change
    create_table :enquiry_infos do |t|
      t.string :title
      t.string :enquiry_content

      t.timestamps null: false
    end
  end
end
