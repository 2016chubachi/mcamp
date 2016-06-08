class PostReply < ActiveRecord::Base
    belongs_to :post
    belongs_to :user
    has_many :postreplyimages,:dependent => :destroy
end
