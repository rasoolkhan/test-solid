module Spree
	module Supplier
    class OptionTypesController < Spree::StoreController
			before_action :this_seller
			before_action :store_approved

      def index
        @option_types = @store.option_types
      end

			def edit
				@option_type = Spree::OptionType.find(params[:id])
				@option_types = @store.option_types
				@option_value = Spree::OptionValue.new
        @option_values = @option_type.option_values
			end

			def update
				@option_type = Spree::OptionType.find(params[:id])
				if @option_type.update(name: params[:option_type][:name], presentation: params[:option_type][:name])
					@option_type.option_values.destroy_all if @option_type.option_values.present?
					option_values = params[:option_values].split(',')
					option_values.each do |option_value|
						Spree::OptionValue.create(option_type: @option_type, name: option_value.strip, presentation: option_value.strip) unless option_value.strip == ""
					end
					redirect_to supplier_store_option_types_path(@store)
				else
					@option_types = @store.option_types
					render 'index'
				end
			end

			def destroy
				@option_type = Spree::OptionType.find(params[:id])
				if @option_type.destroy
					redirect_to supplier_store_option_types_path(@store)
				else
					@option_types = @store.option_types
					render 'index'
				end
			end

      private

			def this_seller
				@store = Spree::Store.friendly.find(params[:store_id])
				correct_seller @store.seller.user
			end

			def store_option_types_params
				params.require(:option_type).permit(:name, :presentation)
			end
    end
	end
end
