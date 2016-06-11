class BorrowReply < ActiveRecord::Base
    belongs_to :borrow_item
    belongs_to :message_state
    has_many :borrow_reply_images,:dependent => :destroy
    belongs_to :user

end
