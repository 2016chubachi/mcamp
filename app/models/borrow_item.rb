class BorrowItem < ActiveRecord::Base
    belongs_to :member
    belongs_to :category
    belongs_to :borrow_state
    has_many :borrow_replies,:dependent => :destroy
    
    validates :item_name,:borrow_state, presence: true
    validates :item_name,:location,length: {maximum: 100}
    validates :item_description,:term,length: {maximum: 500}
    validates :fare,:numericality=>{:only_integer=>true,:greater_than_or_equal_to=>0}

    #該当ユーザーの借りたい一覧
    scope :current_member_borrow_items,->(member){
        where(member_id: member.id,delete_flg: false)
    }
    
    def destroy
        # destroyメソッドをoverwriteして、動きを変える
        self.delete_flg = true
        save
    end

end
