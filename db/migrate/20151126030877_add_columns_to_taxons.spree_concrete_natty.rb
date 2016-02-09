# This migration comes from spree_concrete_natty (originally 20151015114450)
class AddColumnsToTaxons < ActiveRecord::Migration
  def change
	add_column :spree_taxons, :start_date, :datetime
	add_column :spree_taxons, :end_date, :datetime
  end
end
