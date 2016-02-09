# This migration comes from spree_concrete_natty (originally 20150812100418)
class ChangeColumnNameInSpreeStore < ActiveRecord::Migration
  def change
  	remove_column :spree_stores, :spree_seller_id
  	add_reference :spree_stores, :seller, index: true
  end
end
