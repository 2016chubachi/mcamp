class BorrowItem < ActiveRecord::Base
    belongs_to :member
    belongs_to :category
    belongs_to :borrow_state
    has_many :borrow_replies,:dependent => :destroy

end
