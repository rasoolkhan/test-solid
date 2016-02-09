class AddFeaturedToStore < ActiveRecord::Migration
  def change
    add_column :spree_stores, :featured, :boolean, default: :false
  end
end
