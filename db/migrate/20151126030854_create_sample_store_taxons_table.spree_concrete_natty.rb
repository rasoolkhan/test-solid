# This migration comes from spree_concrete_natty (originally 20150827092715)
class CreateSampleStoreTaxonsTable < ActiveRecord::Migration
  def change
  	create_table :spree_sample_store_taxons do |t|
    	t.belongs_to :store, index: true
    	t.belongs_to :taxon, index: true
    end
  end
end
