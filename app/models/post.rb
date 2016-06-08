class Post < ActiveRecord::Base
    belongs_to :user
    belongs_to :poststate
    belongs_to :posttype
    has_many :postimages,:dependent => :destroy
    has_many :postreplys,:dependent => :destroy
end
