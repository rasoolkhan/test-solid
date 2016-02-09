class AddStatusToProduct < ActiveRecord::Migration
  def change
  	add_column :spree_products, :status, :integer
  end
end
