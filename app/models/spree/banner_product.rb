module Spree
	class BannerProduct < ActiveRecord::Base
		validates :product_id, presence: true,uniqueness: true
	end
end