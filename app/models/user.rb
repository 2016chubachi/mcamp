class User < ActiveRecord::Base
    has_many :loanitems
    has_many :requests
    has_many :borrowitems
    has_many :borrowreplys
    has_many :posts
    has_many :postreply
    belongs_to :authority
    belongs_to :generation
end
