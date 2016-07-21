#借りたい送信リクエスト一覧、更新
class BorrowRepliesController < ApplicationController
  before_action :logged_in_member
  def index
    @borrow_replies = BorrowReply.current_member_reply(current_member).order(:message_state_id,updated_at: :DESC).page(params[:page]).per(5)
  end

  def edit
    @borrow_reply = BorrowReply.find(params[:id])
  end

  def update
    @borrow_reply = BorrowReply.find(params[:id])
    begin
      if params[:update]
        #更新
        @borrow_reply.assign_attributes(reply_params)
        #画像の保存
        images = BorrowReplyImage.image_files(params[:borrow_reply][:uploaded_images])
        unless images.empty?
          @borrow_reply.borrow_reply_images.build(images)
        end
        if @borrow_reply.save
          #redirect_to borrow_replies_path
          flash.now[:notice] = "更新しました。"
          render :action => :edit
        else
          flash.now[:notice] = "更新できませんでした。"
          render :action => :edit
        end
      elsif params[:cancel]
        #取消
        ActiveRecord::Base.transaction do
          raise "更新失敗" unless @borrow_reply.update_attribute(:message_state_id,4)
          raise "更新失敗" unless @borrow_reply.borrow_item.update_attribute(:borrow_state_id,1)
        end
        #一覧に遷移
        redirect_to borrow_replies_path
      end

    rescue => e
        #更新失敗の場合
        #更新ページにとどまる
        #承認待ち
        @borrow_reply.message_state_id = 1;
        #処理中
        @borrow_reply.borrow_item.borrow_state_id = 2
        render :action => :edit
    end
  end

  private
    def reply_params
      attrs = [:message]
      params.require(:borrow_reply).permit(attrs)
    end
end
