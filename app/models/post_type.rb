class PostType < ActiveRecord::Base
    has_many :posts
    has_many :postimages
    has_many :postreplyimages
end
