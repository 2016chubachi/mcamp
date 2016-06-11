class Request < ActiveRecord::Base
    belongs_to :loan_item
    belongs_to :user
    belongs_to :message_state

end
