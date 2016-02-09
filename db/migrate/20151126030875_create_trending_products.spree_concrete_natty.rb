# This migration comes from spree_concrete_natty (originally 20151013100115)
class CreateTrendingProducts < ActiveRecord::Migration
  def change
  	drop_table :spree_featured_products if table_exists? :spree_featured_products
    create_table :spree_trending_products do |t|
    	t.integer :product_id
    end
  end
end
