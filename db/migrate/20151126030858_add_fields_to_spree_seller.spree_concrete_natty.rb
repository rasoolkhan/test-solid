# This migration comes from spree_concrete_natty (originally 20150828122201)
class AddFieldsToSpreeSeller < ActiveRecord::Migration
  def change
  	add_column :spree_sellers, :name, :string
  end
end
