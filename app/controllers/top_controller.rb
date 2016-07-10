class TopController < ApplicationController
  def index
    @loanItems = LoanItem.where(delete_flg: false, loan_state_id: 1).order("updated_at DESC").limit(5)
    @borrowItems = BorrowItem.where(delete_flg: false, borrow_state_id: 1).order("updated_at DESC").limit(5)
  end
end
