class LoanItem < ActiveRecord::Base
    belongs_to :user
    belongs_to :category
    belongs_to :loan_state
    has_many :requests,:dependent => :destroy
    has_many :loan_item_images,:dependent => :destroy
end
