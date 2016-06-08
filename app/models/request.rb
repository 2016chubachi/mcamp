class Request < ActiveRecord::Base
    belongs_to :loanitem
    belongs_to :user
    belongs_to :messagestate
end
