class AddStoreToOptionTypes < ActiveRecord::Migration
  def change
    add_column :spree_option_types, :store_id, :integer
    add_index :spree_option_types, :store_id
  end
end
