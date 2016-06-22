class Request < ActiveRecord::Base
    #scope :current_member_request, where('member_id = ?', 3).order('id')
    
    belongs_to :loan_item
    belongs_to :member
    belongs_to :message_state
    validates :message, presence: true
    validates :message_state_id, presence: true
    validates :loan_item_id, presence: true
end
