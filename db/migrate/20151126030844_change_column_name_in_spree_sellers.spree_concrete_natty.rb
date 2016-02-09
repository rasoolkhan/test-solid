# This migration comes from spree_concrete_natty (originally 20150812095922)
class ChangeColumnNameInSpreeSellers < ActiveRecord::Migration
  def change
  	remove_column :spree_sellers, :spree_user_id
  	add_reference :spree_sellers, :user, index: true
  end
end
