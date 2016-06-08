class PostReplyImage < ActiveRecord::Base
    belongs_to :postreply
    belongs_to :posttype
end
