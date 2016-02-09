module Spree
  class ProductFeature < ActiveRecord::Base
    belongs_to :product

    validates :product, presence: true
  end
end
