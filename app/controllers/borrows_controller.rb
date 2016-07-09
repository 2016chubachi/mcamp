#借りる一覧、借りるリクエスト送信
class BorrowsController < ApplicationController
  before_action :logged_in_member, :except => ['index']

  #貸出アイテム一覧表示
  def index
    #削除されていないデータだけ表示
    @loanItems = LoanItem.where(delete_flg: false).order(:loan_state_id)
  end

  def edit
    @loanItem = LoanItem.find(params[:id])
    if @loanItem.loan_state.id==1 && current_member
      #アイテムステータスが「貸出可能」の場合
       @loanItem.requests.build({member_id: current_member.id,message_state_id: 1,delete_flg: false})
    end
  end

  def update
    @loanItem = LoanItem.find(params[:id])
    @loanItem.assign_attributes(loan_item_params)
    #@loanItem.requests.build({member_id: 1,message_state_id: 1,delete_flg: false,message: })
    #@loanItem.attributes=params[:loan_item]
    if @loanItem.save
      flash.now[:notice] = "リクエストを送信しました。"
      @loanItem.update_attribute(:loan_state_id,2)
      render "edit"
    else
      render "edit"
    end
  end
  private
    def loan_item_params
      #attrs = [:item_name, :member_id, :category_id, :item_description,
      #        :fare, :term, :location, :loan_state_id,:delete_flg]
      #attrs << {requests_attributes: [:loan_item_id,:member_id,:message,:message_state_id,:delete_flg]}
      attrs = [:loan_state_id]
      attrs << {requests_attributes: [:loan_item_id,:member_id,:message,:message_state_id,:delete_flg]}
      params.require(:loan_item).permit(attrs)
      #params.require(:loan_item).map do |p|
      #  ActionController::Parameters.new(p.to_hash).permit(:loan_item_id,:member_id,:message,:message_state_id,:delete_flg)
      #end
    end
end
