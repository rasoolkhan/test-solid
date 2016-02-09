# This migration comes from spree_concrete_natty (originally 20150907132901)
class AddBuyerIdToSpreeAddresses < ActiveRecord::Migration
  def change
  	add_column :spree_user_addresses, :buyer_id, :integer
  	add_index :spree_user_addresses, :buyer_id
  end
end
