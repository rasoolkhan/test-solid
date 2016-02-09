module Spree
	Taxon.class_eval do
		has_many :taxons, through: :products
		has_many :sample_store_taxons, dependent: :destroy, class_name: "Spree::SampleStoreTaxon"
		has_many :sample_stores, through: :sample_store_taxons, source: :store, class_name: "Spree::Store"

		def pretty_category
	    pretty_name.split('categories -> ')[1]
	  end
	end
end
