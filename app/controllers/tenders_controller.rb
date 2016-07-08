class TendersController < ApplicationController
  # 借りたい投稿一覧
  def index
    @borrow_items = BorrowItem.current_member_borrow_items(nil).order(:borrow_state_id,:updated_at)
  end

  def show
    #@borrow_item = BorrowItem.find(params[:id])
    #@borrowReplies = @borrow_item.borrow_replies.find_by(member_id: current_member)
    #if current_member && @borrow_item.borrow_state.id==1
    #    #アイテムステータスが「募集中」の場合
    #   @borrow_item.borrow_replies.build({member_id: current_member.id,message_state_id: 1,delete_flg: false})
    #end
    @borrow_item = BorrowItem.find(params[:id])
    #該当ユーザーのリクエスト
    if current_member 
      @borrowReplies = @borrow_item.borrow_replies.where(member_id: current_member)
    end
    #アイテムステータスが「募集中」の場合
    if @borrow_item.borrow_state.id == 1
        @newBorrowReply = BorrowReply.new
    end
  end
  
  def update
    @borrow_item = BorrowItem.find(params[:id])
    #やり方その1
    #@newBorrowReply = BorrowReply.new(borrow_reply_params)
    #@newBorrowReply.borrow_item = @borrow_item
    #@newBorrowReply.member = current_member
    #@newBorrowReply.message_state_id = 1
    #@newBorrowReply.delete_flg = false
    #やり方その2
    @borrow_item.borrow_replies.build({member_id: current_member.id,message_state_id: 1,delete_flg: false}.merge(borrow_reply_params))
    @borrow_item.borrow_state_id = 2
    if @borrow_item.save
      redirect_to @borrow_item ,notice: "リクエストを送信しました。"
    else
      @borrow_item.borrow_state_id = 1
      @borrowReplies = @borrow_item.borrow_replies.where(member_id: current_member)
      @newBorrowReply = BorrowReply.new(borrow_reply_params)
      render "show"
    end
  end
  
  private
  
  def borrow_reply_params
    attrs = [:message]
    params.require(:borrow_item).require(:borrow_reply).permit(attrs)
  end
end
