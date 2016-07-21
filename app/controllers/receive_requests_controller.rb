class ReceiveRequestsController < ApplicationController
  before_action :logged_in_member
  before_action :correct_rec_request_member, only: [:show, :update]

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
    begin
      if params[:accept_request]
        #承認
        ActiveRecord::Base.transaction do
          #承認済み
          raise "更新失敗" unless @receive_request.update_attribute(:message_state_id,2)
          #貸出中
          raise "更新失敗" unless @receive_request.loan_item.update_attribute(:loan_state_id,3)
        end
        # RequestMailer.accept_request(@receive_request).deliver_now
        flash.now[:notice] = "リクエストを承認しました"
        render "show"
      elsif params[:refuse_request]
        #拒否
        ActiveRecord::Base.transaction do
          #拒否済み
          raise "更新失敗" unless @receive_request.update_attribute(:message_state_id,3)
          #貸出可能
          raise "更新失敗" unless @receive_request.loan_item.update_attribute(:loan_state_id,1)
        end
        # RequestMailer.refuse_request(@receive_request).deliver_now
        flash.now[:notice] = "リクエストを拒否しました"
        render "show"
      end
    rescue => e
      # warn "#{e.class}  / #{e.message}"
      #承認待ち
      @receive_request.message_state_id = 1
      #申込中
      @receive_request.loan_item.loan_state_id = 2
      #render text: "例外発生 #{@receive_request.message_state_id} #{@receive_request.loan_item.loan_state_id } "
      render "show"
    end
  end

  private
    def request_params
      attrs = [:message_state_id ]
      params.require(:receive_request).permit(attrs)
    end

end
