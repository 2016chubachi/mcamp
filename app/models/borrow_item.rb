class BorrowItem < ActiveRecord::Base
    belongs_to :member
    belongs_to :category
    belongs_to :borrow_state
    has_many :borrow_replies,:dependent => :destroy
    
    validates :item_name, presence: true
    validates :item_name,:location,length: {maximum: 100}
    validates :item_description,:term,length: {maximum: 500}

    #該当ユーザーの借りたい一覧
    scope :current_member_borrow_items,->(member){
        where(member_id: member.id,delete_flg: false)
    }

end
