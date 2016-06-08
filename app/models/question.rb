class Question < ActiveRecord::Base
    has_many :questiondetails,:dependent => :destroy
end
