class Category < ActiveRecord::Base
    has_many :loanitems
    has_many :borrowitems
end
