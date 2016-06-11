class PostKind < ActiveRecord::Base
    has_many :posts
    has_many :post_images
    has_many :post_reply_images

end
