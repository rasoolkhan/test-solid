# This migration comes from spree_concrete_natty (originally 20150904095223)
class AddStoreOrderIdToSpreeLineItems < ActiveRecord::Migration
  def change
  	add_reference :spree_line_items,:store_order,index: true
  end
end







