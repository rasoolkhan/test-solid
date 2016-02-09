module Spree
	class SampleStoreTaxon < ActiveRecord::Base
		belongs_to :store, class_name: "Spree::Store"
    belongs_to :taxon, class_name: "Spree::Taxon"

		validates :store_id, presence: true
		validates :taxon_id, presence: true
    validates :taxon_id, uniqueness: {scope: :store_id}
	end
end
