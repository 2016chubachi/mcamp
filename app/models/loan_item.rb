class LoanItem < ActiveRecord::Base
    belongs_to :user
    belongs_to :category
    belongs_to :loanstate
    has_many :requests,:dependent => :destroy
    has_many :loanitemimages,:dependent => :destroy
end
