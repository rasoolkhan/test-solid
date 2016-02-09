# This migration comes from spree_concrete_natty (originally 20150828083533)
class CreateTableSpreeProductSamples < ActiveRecord::Migration
  def change
    create_table :spree_product_samples do |t|
    	t.string :name
    	t.string :description
    	t.decimal :price
    	t.references :store, index: true

    end
  end
end
