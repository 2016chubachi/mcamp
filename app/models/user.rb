class User < ActiveRecord::Base
    has_many :loan_items
    has_many :borrow_items
    has_many :borrow_replies
    has_many :posts
    has_many :post_replies
    has_many :requests
    belongs_to :generation
    belongs_to :authority

end
