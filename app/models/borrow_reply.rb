class BorrowReply < ActiveRecord::Base
    belongs_to :borrowitem
    belongs_to :messagestate
    has_many :borrowreplyimages,:dependent => :destroy
end
