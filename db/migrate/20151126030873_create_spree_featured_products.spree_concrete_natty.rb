# This migration comes from spree_concrete_natty (originally 20151009100243)
class CreateSpreeFeaturedProducts < ActiveRecord::Migration
  def change
    create_table :spree_featured_products do |t|
    	t.integer :product_id
	end
  end
end
