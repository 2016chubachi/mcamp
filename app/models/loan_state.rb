class LoanState < ActiveRecord::Base
    has_many :loan_items
end
