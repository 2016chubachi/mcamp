class Authority < ActiveRecord::Base
    has_many :members
    has_many :ad_users

end
