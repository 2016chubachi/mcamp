#借りる送信リクエスト一覧、更新
class RequestsController < ApplicationController
  before_action :logged_in_member

  def index
    @requests = Request.where({member_id: current_member.id,delete_flg: false}).order(:message_state_id,updated_at: :DESC)
  end

  def edit
    @request = Request.find(params[:id])
  end

  def update
    @request = Request.find(params[:id])
    if params[:request_update]
      #更新
      @request.assign_attributes(request_params)
      if @request.save
        self.index()
        render :action => :index
      else
        render :action => :edit
      end
    elsif params[:request_cancel]
      #取消
      @request.update_attribute(:message_state_id,4)
      @request.loan_item.update_attribute(:loan_state_id,1)
      self.index()
      render :action => :index
    end
  end

  private
    def request_params
      attrs = [:loan_item_id, :member_id, :message, :message_state_id,
              :delete_flg]
      params.require(:request).permit(attrs)
    end
end
