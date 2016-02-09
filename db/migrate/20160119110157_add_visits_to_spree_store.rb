class AddVisitsToSpreeStore < ActiveRecord::Migration
  def change
    add_column :spree_stores, :visits, :integer, default: 0
  end
end
