# This migration comes from spree_concrete_natty (originally 20150826134813)
class AddSlugToTables < ActiveRecord::Migration
  def change
  	add_column :spree_sellers, :slug, :string
  	add_column :spree_buyers, :slug, :string
  end
end
