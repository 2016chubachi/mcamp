class TendersController < ApplicationController
  # 借りたい投稿一覧
  def index
    @borrow_items = BorrowItem.current_member_borrow_items(nil).order(:borrow_state_id,:updated_at)
  end

  def show
    @borrow_item = BorrowItem.find(params[:id])
    if current_member && @borrow_item.borrow_state.id==1
        #アイテムステータスが「募集中」の場合
       @borrow_item.borrow_replies.build({member_id: current_member.id,message_state_id: 1,delete_flg: false})
    end
  end
  
  def update
    @borrow_item = BorrowItem.find(params[:id])
    binding.pry
    @borrow_item.assign_attributes(borrow_reply_params)
    if @borrow_item.save
      flash.now[:notice] = "リクエストを送信しました。"
      @borrow_item.update_attribute(:borrow_state_id,2)
      render "show"
    else
      render "show"
    end
  end
  
  private
  
  def borrow_reply_params
    attrs = []
    attrs << {borrow_replies_attributes: [:borrow_item_id,:member_id,:message,:message_state_id,:delete_flg]}
    params.require(:borrow_item).permit(attrs)
  end
end
