# This migration comes from spree_concrete_natty (originally 20150812095710)
class ChangeColumnNameInSpreeBuyers < ActiveRecord::Migration
  def change
  	remove_column :spree_buyers, :spree_user_id
  	add_reference :spree_buyers, :user, index: true
  end
end
