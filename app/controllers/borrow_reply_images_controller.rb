class BorrowReplyImagesController < ApplicationController
  def show
    @image = BorrowReplyImage.find(params[:id])
    send_data(@image.image, :type => @image.content_type, :disposition => "inline")
  end
end
