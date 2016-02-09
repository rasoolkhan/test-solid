# This migration comes from spree_concrete_natty (originally 20151014122741)
class CreateSpreeBannerProducts < ActiveRecord::Migration
  def change
    create_table :spree_banner_products do |t|
    	t.integer :product_id
    end
  end
end
