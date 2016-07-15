#借りる一覧、借りるリクエスト送信
class BorrowsController < ApplicationController
  before_action :logged_in_member, :except => ['index']

  #貸出アイテム一覧表示
  def index
    #削除されていないデータだけ表示
    @loanItems = LoanItem.where(delete_flg: false).order(:loan_state_id,updated_at: :DESC).page(params[:page]).per(5)
  end

  def edit
    #実装方法変更
    # @loanItem = LoanItem.find(params[:id])
    # if @loanItem.loan_state.id==1 && current_member
    #   #アイテムステータスが「貸出可能」の場合
    #    @loanItem.requests.build({member_id: current_member.id,message_state_id: 1,delete_flg: false})
    # end
    @loanItem = LoanItem.find(params[:id])
    #ログインされている場合
    if current_member
        @requests = @loanItem.requests.where(member_id: current_member.id).page(params[:page]).per(3)
    end
    #該当アイテムの状態が：貸出可能
    if @loanItem.loan_state_id == 1
        @newRequest = Request.new
    end
  end

  def update
    @loanItem = LoanItem.find(params[:id])
    @loanItem.requests.build({member_id: current_member.id,message_state_id: 1,delete_flg: false}.merge(request_params))
    #@loanItem.requests.build(request_params[:requests_attributes]["0"].merge({member_id: current_member.id,message_state_id: 1,delete_flg: false}))
    #@loanItem.assign_attributes(request_params[:requests_attributes]["0"].merge({member_id: current_member.id,message_state_id: 1,delete_flg: false}))
    #request_params[:requests_attributes]["0"][:message]
    #request_params[:requests_attributes]["0"].merge({member_id: current_member.id,message_state_id: 1,delete_flg: false})
    @loanItem.loan_state_id = 2
    if @loanItem.save
      flash.now[:notice] = "リクエストを送信しました。"
      #メール送信
      #RequestMailer.send_request(Request.where(member_id: current_member.id).order(id: :DESC).limit(1)[0]).deliver_now
      @requests = @loanItem.requests.where(member_id: current_member.id).page(params[:page]).per(3)
      render "edit"
    else
      @loanItem.loan_state_id = 1
      @requests = @loanItem.requests.where(member_id: current_member).page(params[:page]).per(3)
      @newRequest = Request.new(request_params)
      render "edit"
    end
  end

  private
    def request_params
      attrs = [:message]
      params.require(:loan_item).require(:request).permit(attrs)
      #attrs = []
      #attrs << {requests_attributes: [:message]}
      #params.require(:loan_item).permit(attrs)
    end
end
