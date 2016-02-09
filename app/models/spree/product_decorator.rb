module Spree
  Product.class_eval do
    include ActionView::Helpers::NumberHelper

    enum status: [:pending, :approved, :declined, :suspended]

   	delegate_belongs_to :master, :sale_price
    belongs_to :store
    has_many :specifications
    has_many :product_features
    has_one :guide, as: :viewable, dependent: :destroy, class_name: "Spree::ImageGuide"
    has_many :product_ratings

    self.whitelisted_ransackable_associations = %w[store stores variants_including_master master variants]

    def admin_sale_price(currency)
      master.sale_price
    end

    def selectHashJson(params)
      selections = {}
      params.delete :controller
      params.delete :action
      params.each do |type, value|
        selections[Spree::OptionType.find(type)] = Spree::OptionValue.find(value)
      end
      selectHash selections, true
    end

    def selectHash(selections = nil, json = false)
      selectMenus = []
      selectedVariant = self.variants.first
      selectedImages = {product: [], mini: []}
      if self.variants_and_option_values.any?
        if selections == nil
          selections = {}
          self.variant_option_values_by_option_type(Spree::Variant.where(id: self.variants.first.id)).each do |type, values|
            selections[type] = values[0]
          end
        end
        curr_variants = self.variants.pluck(:id)
        product_types = self.variant_option_values_by_option_type.keys
        value_first = self.variant_option_values_by_option_type(Spree::Variant.where(id: curr_variants))[product_types.first][0]
        self.variants.each do |variant|
          if variant.option_values.include? value_first
            selectedVariant = variant
            break
          end
        end
        product_types.each do |type|
          values = self.variant_option_values_by_option_type(Spree::Variant.where(id: curr_variants))[type]
          if values.present?
            selectedVariantValue = selectedVariant.option_values.where(option_type: type).first
            if selections[type].present? && values.include?(selections[type])
              value = selections[type]
            else
              value = selectedVariantValue
            end
            selectMenus << {type: json ? {name: type.presentation, id: type.id} : type, values: json ? values.collect {|v| {name: v.presentation, id: v.id}} : values, value: json ? {name: value.name, id: value.id} : value}
            next_variants = []
            curr_variants.each_with_index do |id, index|
              next_variants << id if Spree::Variant.find(id).option_values.where(id: value.id).any?
              selectedVariant = Spree::Variant.find(next_variants[0]) if next_variants.length == 1
            end
            curr_variants = next_variants
          else
            curr_variants = 0
          end
        end
      end
      images = selectedVariant.images.any? ? selectedVariant.images : self.master_images
      images.each do |image|
        selectedImages[:product] << image.attachment.url
        selectedImages[:mini] << image.attachment.url(:mini)
      end
      selectedAvailability = selectedVariant.stock_items.first.count_on_hand > 0
      {store: self.store.id, variant: selectedVariant.id, menus: selectMenus, images: selectedImages, price: json ? number_with_delimiter(selectedVariant.price.to_i, locale: :in) : selectedVariant.price, available: selectedAvailability, sku: selectedVariant.sku.split('-', 2)[1]}
    end

    def lowest_price
      prices = variants.map {|v| v.price.to_f}
      prices.min
    end

    scope :valid, -> { approved.joins(:variants).group('spree_products.id') }
  end
end
