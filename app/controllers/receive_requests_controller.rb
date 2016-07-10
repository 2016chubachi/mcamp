class ReceiveRequestsController < ApplicationController
  def index
    # joins(:関連名).where(テーブル名: {member_id: 1} )
    # @receive_requests = Request.joins(:loan_item).where(loan_items: {member_id: current_member.id} )

    #includesを使用
    #includesの方がSQLの発行回数が少なくなる。N+1問題対策　requests left outer join loan_items となるが
    #requestsは全件でても問題ないと思う
    @receive_requests = Request.includes(:loan_item).where(loan_items: {member_id: current_member.id})
                                                    .where.not(message_state_id: [4])
                                                    .order(:message_state_id, updated_at: :DESC)


  end

  def show
    @receive_request  = Request.find(params[:id])
  end

  def update
    @receive_request = Request.find(params[:id])
    if params[:accept_request]
      @receive_request.update_attribute(:message_state_id,2)
      @receive_request.loan_item.update_attribute(:loan_state_id,3)
      # RequestMailer.accept_request(@receive_request).deliver_now
      flash.now[:notice] = "リクエストを承認しました"
      render "show"
    elsif params[:refuse_request]
      @receive_request.update_attribute(:message_state_id,3)
      @receive_request.loan_item.update_attribute(:loan_state_id,1)
      # RequestMailer.refuse_request(@receive_request).deliver_now
      flash.now[:notice] = "リクエストを拒否しました"
      render "show"
    end
  end

  private
    def request_params
      attrs = [:message_state_id ]
      params.require(:receive_request).permit(attrs)
    end

end
