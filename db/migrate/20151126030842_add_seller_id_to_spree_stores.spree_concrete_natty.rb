# This migration comes from spree_concrete_natty (originally 20150812074514)
class AddSellerIdToSpreeStores < ActiveRecord::Migration
  def change
  	add_reference :spree_stores, :spree_seller, index: true
  end
end
