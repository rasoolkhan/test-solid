module Spree
	TaxonsController.class_eval do
    include ApplicationHelper

    def index
      retVal = {}
      retVal[:l2s] = params[:l1].present? ? level_2_categories(Spree::Taxon.find(params[:l1]).name).map {|taxon| [taxon.id, taxon.name]} : [] if params[:c] == 'l1'
      retVal[:l3s] = params[:l2].present? ? level_3_categories(Spree::Taxon.find(params[:l1]), Spree::Taxon.find(params[:l2]).name).map {|taxon| [taxon.id, taxon.name]} : [] if params[:c] == 'l2'
      respond_to do |format|
        format.json {render json: retVal}
      end
    end
  end
end
