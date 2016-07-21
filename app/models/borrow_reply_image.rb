class BorrowReplyImage < ActiveRecord::Base
    belongs_to :borrow_reply
    #attr_reader :uploaded_images

    IMAGE_TYPES =
      { "image/jpeg" => "jpg", "image/gif" => "gif", "image/png" => "png" }

    def extension
      IMAGE_TYPES[content_type]
    end

  class << self
      def image_files(files)
        images = []
        file = {}
        if files != nil
          files.each do |f|
            file = {}
            file[:content_type] = BorrowReplyImage.get_content_type(f.content_type)
            file[:image] = f.read
            images << file
          end
        end
        return images
      end

      def get_content_type(ctype)
        case ctype.rstrip.downcase
        when "image/pjpeg" then "image/jpeg"
        when "image/jpg" then "image/jpeg"
        when "image/x-png" then "image/png"
        else
          ctype.rstrip.downcase
        end
      end
  end

end
