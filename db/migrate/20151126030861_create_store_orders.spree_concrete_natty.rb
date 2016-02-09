# This migration comes from spree_concrete_natty (originally 20150904094827)
class CreateStoreOrders < ActiveRecord::Migration
  def change
  	drop_table :seller_orders if table_exists? :seller_orders
    create_table :spree_store_orders do |t|
    	t.references :order, index: true
    	t.references :store, index: true
    end
  end
end
