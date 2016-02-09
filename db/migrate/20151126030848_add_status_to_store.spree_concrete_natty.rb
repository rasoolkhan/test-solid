# This migration comes from spree_concrete_natty (originally 20150814123451)
class AddStatusToStore < ActiveRecord::Migration
  def change
  	add_column :spree_stores, :status, :integer
  end
end
