class AddLabelModificationsToProduct < ActiveRecord::Migration
  def change
    add_column :spree_products, :properties_label, :string
    add_column :spree_products, :guide_label, :string
  end
end
