module Spree
	ProductsController.class_eval do
    def show
			redirect_to spree.root_path unless (@product.approved? && @product.has_variants? && @product.store.seller.products_allowed?) || (@product.has_variants? && spree_current_user && spree_current_user.admin?)
			@store = @product.store
			@page = params[:page].present? ? params[:page].to_i : 1
			@count = 3
			@products = @store.products.valid.where.not(id: @product.id).page(@page).per(@count)
      @product_properties = @product.product_properties.includes(:property)
      @selectHash = @product.selectHash
    end

		def variant
			product = Spree::Product.find(params[:id])
			params.delete :id
			render json: product.selectHashJson(params).to_json
		end
  end
end
