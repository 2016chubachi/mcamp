class ReceiveRequestsController < ApplicationController
  def index
    # joins(:関連名).where(テーブル名: {member_id: 1} )
    # @receive_requests = Request.joins(:loan_item).where(loan_items: {member_id: current_member.id} )

    #includesを使用
    #includesの方がSQLの発行回数が少なくなる。N+1問題対策　requests left outer join loan_items となるが
    #requestsは全件でても問題ないと思う
    @receive_requests = Request.includes(:loan_item).where(loan_items: {member_id: current_member.id})
  end

  def show
    @receive_request  = Request.find(params[:id])
  end

  def update
    @receive_request = Request.find(params[:id])
    if params[:accept_request]
      @receive_request.update_attribute(:message_state_id,2)
      RequestMailer.accept_request(@receive_request).deliver_now
      flash.now[:notice] = "リクエストを承認しました"
      render "show"
    elsif params[:refuse_request]
      @receive_request.update_attribute(:message_state_id,3)
      RequestMailer.refuse_request(@receive_request).deliver_now
      flash.now[:notice] = "リクエストを拒否しました"
      render "show"
    end
  end

  private
    def request_params
      attrs = [:loan_item_id, :member_id, :message, :message_state_id,
              :delete_flg]
      params.require(:receive_request).permit(attrs)
    end

end
