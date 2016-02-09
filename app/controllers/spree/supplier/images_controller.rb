module Spree
  module Supplier
    class ImagesController < Spree::Admin::ImagesController

      def new
      end

      
      def load_index_data
        @product = Product.friendly.includes(*variant_index_includes).find(params[:product_id])
        @store = Store.find(params[:store_id])
      end
      

      def create
      end

    end
  end
end