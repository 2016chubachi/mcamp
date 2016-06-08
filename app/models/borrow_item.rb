class BorrowItem < ActiveRecord::Base
    belongs_to :user
    belongs_to :category
    belongs_to :borrowstate_id
    has_many :borrowreplys,:dependent => :destroy
end
