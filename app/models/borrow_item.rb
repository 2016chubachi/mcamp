class BorrowItem < ActiveRecord::Base
    belongs_to :member
    belongs_to :category
    belongs_to :borrow_state
    has_many :borrow_replies,-> {where(delete_flg: false)},:dependent => :destroy

    accepts_nested_attributes_for :borrow_replies

    validates :item_name,:borrow_state, presence: true
    validates :item_name,:location,length: {maximum: 100}
    validates :item_description,:term,length: {maximum: 500}
    validates :fare,:numericality=>{:only_integer=>true,:greater_than_or_equal_to=>0}

    #該当ユーザーの借りたい一覧
    scope :current_member_borrow_items,->(member){
        if member
            where(member_id: member.id,delete_flg: false)
        else
            where(delete_flg: false)
        end
    }

    def destroy
        # destroyメソッドをoverwriteして、動きを変える
        self.delete_flg = true
        #関連データを削除する
        self.borrow_replies.each do |reply|
          reply.destroy
        end
        save
    end

end
