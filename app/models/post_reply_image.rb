class PostReplyImage < ActiveRecord::Base
    belongs_to :post_reply
    belongs_to :post_kind

end
