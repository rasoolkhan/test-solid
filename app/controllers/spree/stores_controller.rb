module Spree
	class StoresController < Spree::StoreController
		include ApplicationHelper

    def index
			@page = params[:page].present? ? params[:page].to_i : 1
      @count = 3
      stores = Spree::Store.where.not(id: 1).approved
			@stores = stores.page(@page).per(@count)
			@featured = stores.approved.where(featured: true)
			@category_options = ['All'] + main_categories.pluck(:name)
    end

    def show
      @store = Spree::Store.friendly.find(params[:id])
      @page = params[:page].present? ? params[:page].to_i : 1
      @count = 9
			if @store.seller.products_allowed?
      	@products = @store.products.valid.order(id: :desc).page(@page).per(@count)
			else
				@products = []
			end
			@store.update(visits: @store.visits + 1)
    end

		def filter
			puts params
			render json: {}.to_json
		end
	end
end
