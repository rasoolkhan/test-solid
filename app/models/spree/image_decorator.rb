module Spree
  Image.class_eval do
    validates_attachment_size :attachment, less_than: 2.megabytes
    attachment_definitions[:attachment][:styles] = { mini: '72x72#', cart: '123x88#', small: '200x200#', thumb: '400x320#', quick: '574x388#', product: '800x555#' }
    attachment_definitions[:attachment][:default_url] = '/images/stores/products/:style.png'
    attachment_definitions[:attachment][:url] = Rails.env.production? ? ':s3_domain_url' : "/images/stores/:sid/products/:pid/:id/:slug-:style.:extension"
    attachment_definitions[:attachment][:path] = Rails.env.production? ? '/images/stores/:sid/products/:pid/:id/:slug-:style.:extension' : ':rails_root/public/images/stores/:sid/products/:pid/:id/:slug-:style.:extension'
  end
end
