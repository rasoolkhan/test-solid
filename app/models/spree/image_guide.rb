module Spree
  class ImageGuide < Asset
    validate :no_attachment_errors

    has_attached_file :attachment,
                      default_url: '/images/stores/guides/:style.png',
                      url: Rails.env.production? ? ':s3_domain_url' : '/images/stores/:sid/products/:pid/guides/:id/:style.:extension',
                      path: Rails.env.production? ? '/images/stores/:sid/products/:pid/guides/:id/:style.:extension' : ':rails_root/public/images/stores/:sid/products/:pid/guides/:id/:style.:extension',
                      convert_options: { all: '-strip -auto-orient -colorspace sRGB' }
    validates_attachment :attachment,
      :presence => true,
      :content_type => { :content_type => %w(image/jpeg image/jpg image/png image/gif application/pdf) },
      :size => { less_than: 2.megabytes }

    # save the w,h of the original image (from which others can be calculated)
    # we need to look at the write-queue for images which have not been saved yet
    after_post_process :find_dimensions

    #used by admin products autocomplete
    def mini_url
      attachment.url(:mini, false)
    end

    def find_dimensions
      temporary = attachment.queued_for_write[:original]
      filename = temporary.path unless temporary.nil?
      filename = attachment.path if filename.blank?
      if attachment.instance.attachment_content_type == 'application/pdf'
        self.attachment_width  = 0
        self.attachment_height = 0
      else
        geometry = Paperclip::Geometry.from_file(filename)
        self.attachment_width  = geometry.width
        self.attachment_height = geometry.height
      end
    end

    # if there are errors from the plugin, then add a more meaningful message
    def no_attachment_errors
      unless attachment.errors.empty?
        # uncomment this to get rid of the less-than-useful interim messages
        # errors.clear
        errors.add :attachment, "Paperclip returned errors for file '#{attachment_file_name}' - check ImageMagick installation or image source file."
        false
      end
    end
  end
end
