module Spree
	StoreController.class_eval do

    def show
      @store = Spree::Store.friendly.find(params[:id])
      @products = @store.products.order(id: :desc)
    end

    def index
    end

  end

end
