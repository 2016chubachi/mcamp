class Category < ActiveRecord::Base
    has_many :loan_items
    has_many :borrow_items

end
