class AddStoreToPrototypes < ActiveRecord::Migration
  def change
    add_column :spree_prototypes, :store_id, :integer
    add_index :spree_prototypes, :store_id
  end
end
