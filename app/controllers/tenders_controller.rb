#用品提供一覧、用品提供リクエスト送信
class TendersController < ApplicationController
  before_action :logged_in_member, :except => ['index','search']

  # 用品提供投稿一覧
  def index
    @borrow_items = BorrowItem.current_member_borrow_items(nil).order(:borrow_state_id,updated_at: :DESC).page(params[:page]).per(5)
  end

  def edit
    #@borrow_item = BorrowItem.find(params[:id])
    #@borrowReplies = @borrow_item.borrow_replies.find_by(member_id: current_member)
    #if current_member && @borrow_item.borrow_state.id==1
    #    #アイテムステータスが「募集中」の場合
    #   @borrow_item.borrow_replies.build({member_id: current_member.id,message_state_id: 1,delete_flg: false})
    #end
    @borrow_item = BorrowItem.find(params[:id])
    if current_member.id != @borrow_item.member_id
      #該当ユーザーのリクエスト
      if current_member
        @borrowReplies = @borrow_item.borrow_replies.where(member_id: current_member).page(params[:page]).per(3)
      end
      #アイテムステータスが「募集中」の場合
      if @borrow_item.borrow_state.id == 1
          @newBorrowReply = BorrowReply.new
      end
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
    #http://tkot.hatenablog.com/entry/2013/07/06/010617
    if @borrow_item.save
      flash.now[:notice] = "リクエストを送信しました。"
      #画像の保存
      images = BorrowReplyImage.image_files(params[:borrow_item][:uploaded_images])
      unless images.empty?
        reply = @borrow_item.borrow_replies.where(member_id: current_member).last
        reply.borrow_reply_images.build(images)
        reply.save
      end
      @borrowReplies = @borrow_item.borrow_replies.where(member_id: current_member).page(params[:page]).per(3)
      render "edit"
    else
      @borrow_item.borrow_state_id = 1
      @borrowReplies = @borrow_item.borrow_replies.where(member_id: current_member).page(params[:page]).per(3)
      @newBorrowReply = BorrowReply.new(borrow_reply_params)
      render "edit"
    end
  end

  def search
    @borrow_items = BorrowItem.search(params[:q]).current_member_borrow_items(nil).order(:borrow_state_id,updated_at: :DESC).page(params[:page]).per(5)
    render "index"
  end

  private

  def borrow_reply_params
    attrs = [:message]
    params.require(:borrow_item).require(:borrow_reply).permit(attrs)
  end
end
