class BorrowReplyImagesController < ApplicationController
  before_action :logged_in_member
  
  def show
    @image = BorrowReplyImage.find(params[:id])
    if params[:format].in?(["jpg", "png","gif"])
      send_data(@image.image, :type => @image.content_type, :disposition => "inline")
    end
  end

  def destroy
    @image = BorrowReplyImage.find(params[:id])
    _message = ""
    if @image.destroy
      _message = "画像を削除しました。"
      #@borrow_reply = BorrowReply.find(params[:borrow_reply_id])
    else
      _message = "画像を削除できませんでした。"
    end
    #render "borrow_replies/edit"
    redirect_to edit_borrow_reply_url(id: params[:borrow_reply_id]),notice: _message
  end
end
