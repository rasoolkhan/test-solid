module Spree
	module Admin
		class BannerProductsController < Spree::BaseController

      def create
        banner_product = Spree::Product.find(params[:product_id])
        b_product=Spree::BannerProduct.new(product_id: banner_product.id)
        if b_product.save!
          redirect_to :back
        end
      end

      def index
        
      end

      def destroy
        b_product = Spree::BannerProduct.find(params[:id])
        b.product.destroy!
      end
		end
	end
end