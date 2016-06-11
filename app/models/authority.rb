class Authority < ActiveRecord::Base
    has_many :users
    has_many :ad_users

end
