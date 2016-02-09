module Spree
  module Admin
    class StoresController < ResourceController
      def index
        session[:return_to] = request.url
        respond_to do |format|
          format.html
          format.csv { send_data @collection.to_csv }
          format.xls
        end
      end

      def pending
        session[:return_to] = request.url
        collection
        @collection = Spree::Store.pending.page(params[:page]).per(10)
        render 'index'
      end

      def approved
        session[:return_to] = request.url
        collection
        @collection = Spree::Store.approved.page(params[:page]).per(10)
        render 'index'
      end

      def featured
        session[:return_to] = request.url
        collection
        @collection = Spree::Store.approved.where(featured: true).page(params[:page]).per(10)
        render 'index'
      end

      def show
        session[:return_to] = request.url
      end

      def update
        if params[:status] == "approved"
          unless @store.approved?
            @store.approved!
            Spree::ApprovalMailer.store_approved_email(@store).deliver_later
          end
        else
          @store.pending!
        end
        if @store.update(store_params)
          redirect_to admin_stores_url
        else
          render 'edit'
        end
      end

      private

        def collection
          params[:q] ||= {}
          params[:q][:s] ||= "name asc"
          @collection = super
          @search = @collection.ransack(params[:q])
          @collection = @search.result.page(params[:page]).per(10)
          @collection
        end

        def find_resource
          Store.friendly.find(params[:id])
        end

        def store_params
          params.require(:store).permit(:featured)
        end
    end
  end
end
