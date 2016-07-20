class BorrowReplyImagesController < ApplicationController
  def show
    @image = BorrowReplyImage.find(params[:id])
    if params[:format].in?(["jpg", "png","gif"])
      send_data(@image.image, :type => @image.content_type, :disposition => "inline")
    end
  end
end
