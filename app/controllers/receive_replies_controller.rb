#受信リクエスト一覧
class ReceiveRepliesController < ApplicationController
  before_action :logged_in_member

  def index
    @replies =BorrowReply.includes(:borrow_item).
              where(borrow_items: {member_id: current_member.id,delete_flg: false},
              borrow_replies: {message_state_id: [1,2,3],delete_flg: false}).order(updated_at: :DESC).page(params[:page]).per(5)
  end

  def edit
    @reply = BorrowReply.find(params[:id])
  end

  def update
    @reply = BorrowReply.find(params[:id])
    begin
      if params[:approval]
        #承認
        ActiveRecord::Base.transaction do
          #承認済み
          raise "更新失敗" unless @reply.update_attribute(:message_state_id,2)
          #締切
          raise "更新失敗" unless @reply.borrow_item.update_attribute(:borrow_state_id,3)
        end
        flash.now[:notice] = "承認しました。"
        render :action => :edit
      elsif params[:rejection]
        #拒否
        ActiveRecord::Base.transaction do
          #拒否
          raise "更新失敗" unless @reply.update_attribute(:message_state_id,3)
          #募集中
          raise "更新失敗" unless @reply.borrow_item.update_attribute(:borrow_state_id,1)
        end
        flash.now[:notice] = "拒否しました。"
        render :action => :edit
      end

    rescue => e
        #更新失敗の場合
        #更新ページにとどまる
        #承認待ち
        @reply.message_state_id = 1;
        #処理中
        @reply.borrow_item.borrow_state_id = 2
        render :action => :edit
    end
  end
end
