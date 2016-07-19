module ApplicationHelper
  def loan_item_image_tag(loan_item, options ={})
    if loan_item.loan_item_image.present?
      path = loan_item_path(loan_item,format: loan_item.loan_item_image.extension)
      link_to(image_tag(path,{ alt: loan_item.item_name}.merge(options)), path)
    else
    end
  end

  def borrow_reply_image_tag(reply,reply_image, options ={})
    if reply_image != nil
      #path = url_for(:controller => 'borrow_replies',:action => 'get_image',:id => reply_image.id,format: reply_image.extension)
      path = borrow_reply_borrow_reply_image_path(reply,reply_image,format: reply_image.extension)
      link_to(image_tag(path,{ alt: truncate(reply_image.borrow_reply.message,length: 10)}.merge(options)), path,:target => "_blank" )
    else
    end
  end
end
