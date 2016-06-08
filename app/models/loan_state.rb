class LoanState < ActiveRecord::Base
    has_many :loanitems
end
