class BorrowReply < ActiveRecord::Base
    belongs_to :borrow_item
    belongs_to :message_state
    has_many :borrow_reply_images,:dependent => :destroy
    belongs_to :member

    validates :borrow_item_id,:member_id,:message,:message_state_id, presence: true
    validates :message,length: {maximum: 500}
    
    scope :current_member_reply,->(member){
        where(member_id: member.id,delete_flg: false)
    }
    
end
