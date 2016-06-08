class PostImage < ActiveRecord::Base
    belongs_to :post
    belongs_to :posttype
end
