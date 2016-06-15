module ApplicationHelper
  def loan_item_image_tag(loan_item, options ={})
    if loan_item.loan_item_image.present?
      path = loan_item_path(loan_item,format: loan_item.loan_item_image.extension)
      link_to(image_tag(path,{ alt: loan_item.item_name}.merge(options)), path)
    else
    end
  end
end
