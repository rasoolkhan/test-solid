class AddStoreToStockLocationsTable < ActiveRecord::Migration
  def change
    add_column :spree_stock_locations, :store_id, :integer
    add_index :spree_stock_locations, :store_id
  end
end
