Rails.application.config.spree.payment_methods << Spree::Gateway::PayuIn

Spree::PermittedAttributes.module_eval do

  def self.newsletter_signup_attributes
    [:email]
  end

  self.user_attributes << [:first_name, :last_name, :email]
  self.user_attributes.flatten!(1)

  self.store_attributes << [:name, :description, :hearaboutus, :slug,
    seller_attributes: [:user_id, :name, :alternate_name, :alternate_email, :alternate_phone],
    office_address_attributes: [:user_id, :default, :archived,
      address_attributes: [:firstname, :lastname, :address1, :address2, :city, :zipcode, :state_id, :phone]],
    product_samples_attributes: [:name, :description, :price,
      image_attributes: self.image_attributes],
    image_attributes: self.image_attributes,
    logo_attributes: self.image_attributes,
    policies_attributes: [:heading, :description]
  ]
  self.store_attributes.flatten!(1)




  def self.buyer_attributes
    [:name,:phone_number, ship_addresses_attributes: [:firstname,:lastname,:address1,:address2,:city,:zipcode,:state_name,:country_id,:state_id,:phone]]
  end

  def self.store_order_attributes
    [:order_id]
  end

  self.line_item_attributes << :store_order_id

  self.product_attributes << :shipping_rate

end

if Rails.env.production?
  attachment_config = {

    s3_credentials: {
      access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
      secret_access_key: ENV['AWS_SECRET_KEY'],
      bucket:            ENV['S3_BUCKET']
    },

    storage:        :s3,
    s3_headers:     { "Cache-Control" => "max-age=31557600" },
    s3_protocol:    "https",
    bucket:         ENV['S3_BUCKET'],
    s3_region:      'ap-southeast-1'
  }

  attachment_config.each do |key, value|
    Spree::Image.attachment_definitions[:attachment][key.to_sym] = value
    Spree::ImageLogo.attachment_definitions[:attachment][key.to_sym] = value
    Spree::ImageBanner.attachment_definitions[:attachment][key.to_sym] = value
  end
end
