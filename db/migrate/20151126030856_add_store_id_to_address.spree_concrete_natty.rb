# This migration comes from spree_concrete_natty (originally 20150827124752)
class AddStoreIdToAddress < ActiveRecord::Migration
  def change
  	add_column :spree_user_addresses, :store_id, :integer
  	add_index :spree_user_addresses, :store_id
  end
end
