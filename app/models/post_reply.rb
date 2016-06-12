class PostReply < ActiveRecord::Base
    belongs_to :post
    belongs_to :member
    has_many :post_reply_images,:dependent => :destroy

end
