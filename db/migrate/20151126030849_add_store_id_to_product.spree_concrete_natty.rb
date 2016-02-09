# This migration comes from spree_concrete_natty (originally 20150817130850)
class AddStoreIdToProduct < ActiveRecord::Migration
  def change
  	add_reference :spree_products, :store
  end
end
