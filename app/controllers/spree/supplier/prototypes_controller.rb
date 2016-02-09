module Spree
	module Supplier
    class PrototypesController < Spree::StoreController
			before_action :this_seller
			before_action :store_approved

      def index
        @prototype = Spree::Prototype.new
        @prototypes = @store.prototypes
      end

			def create
				@prototype = Spree::Prototype.new(store_prototypes_params)
				@prototype.store = @store
				if @prototype.save
					@prototype.properties = Spree::Property.find(params[:prototype][:property_ids].select { |id| id != "" })
					@prototype.option_types = Spree::OptionType.find(params[:prototype][:option_type_ids].select { |id| id != "" })
					@prototype.taxons = Spree::Taxon.find(params[:prototype][:taxon_ids].select { |id| id != "" })
					redirect_to supplier_store_prototypes_path(@store)
				else
					@prototypes = @store.prototype
					render 'index'
				end
			end

			def edit
				@prototype = Spree::Prototype.find(params[:id])
				@prototypes = @store.prototypes
			end

			def update
				@prototype = Spree::Prototype.find(params[:id])
				if @prototype.update(store_prototypes_params)
					@prototype.properties = Spree::Property.find(params[:prototype][:property_ids].select { |id| id != "" })
					@prototype.option_types = Spree::OptionType.find(params[:prototype][:option_type_ids].select { |id| id != "" })
					@prototype.taxons = Spree::Taxon.find(params[:prototype][:taxon_ids].select { |id| id != "" })
					redirect_to supplier_store_prototypes_path(@store)
				else
					@prototypes = @store.prototypes
					render 'index'
				end
			end

			def destroy
				@prototype = Spree::Prototype.find(params[:id])
				if @prototype.destroy
					redirect_to supplier_store_prototypes_path(@store)
				else
					@prototypes = @store.prototypes
					render 'index'
				end
			end

      private

			def this_seller
				@store = Spree::Store.friendly.find(params[:store_id])
				correct_seller @store.seller.user
			end

			def store_prototypes_params
				params.require(:prototype).permit(:name)
			end
    end
	end
end
