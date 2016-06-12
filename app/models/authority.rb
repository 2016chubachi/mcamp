class Authority < ActiveRecord::Base
    has_many :member
    has_many :ad_users

end
