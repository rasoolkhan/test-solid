module Spree
  module Admin
    TaxonsController.class_eval do
    	def update
        parent_id = params[:taxon][:parent_id]
        set_position
        set_parent(parent_id)

        if params[:add_to_natty_pick].present? && params[:add_to_natty_pick] == "1"
          natty_pick_cat = Spree::NattyPick.new(taxon_id: @taxon.id)
          natty_pick_cat.save!
        end

        @taxon.save!

        # regenerate permalink
        regenerate_permalink if parent_id

        set_permalink_params

        #check if we need to rename child taxons if parent name or permalink changes
        @update_children = true if params[:taxon][:name] != @taxon.name || params[:taxon][:permalink] != @taxon.permalink

        if @taxon.update_attributes(taxon_params)
          flash[:success] = flash_message_for(@taxon, :successfully_updated)
        end

        #rename child taxons
        rename_child_taxons if @update_children

        respond_with(@taxon) do |format|
          format.html {redirect_to edit_admin_taxonomy_url(@taxonomy) }
          format.json {render :json => @taxon.to_json }
        end
      end

    end
  end
end
