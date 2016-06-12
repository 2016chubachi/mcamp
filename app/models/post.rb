class Post < ActiveRecord::Base
    belongs_to :member
    belongs_to :post_state
    belongs_to :post_kind
    has_many :post_images,:dependent => :destroy
    has_many :post_replies,:dependent => :destroy

end
