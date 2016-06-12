class Request < ActiveRecord::Base
    belongs_to :loan_item
    belongs_to :member
    belongs_to :message_state

end
