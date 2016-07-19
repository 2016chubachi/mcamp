class AddAgreementToMembers < ActiveRecord::Migration
  def change
    add_column :members, :agreement, :boolean, default: false
  end
end
