class LoanItemImage < ActiveRecord::Base
    belongs_to :loan_item

    attr_reader :uploaded_image

    IMAGE_TYPES =
      { "image/jpeg" => "jpg", "image/gif" => "gif", "image/png" => "png" }

    def extension
      IMAGE_TYPES[content_type]
    end

    def uploaded_image=(image)
      self.content_type = convert_content_type(image.content_type)
      self.image = image.image
      @uploaded_image = image
    end

    private
    def convert_content_type(ctype)
      ctype = ctype.rstrip.downcase
      case ctype
        when "image/pjpeg" then "image/jpeg"
        when "image/jpg" then "image/jpeg"
        when "image/x-png" then "image/jpeg"
        else ctype
      end
    end

end
