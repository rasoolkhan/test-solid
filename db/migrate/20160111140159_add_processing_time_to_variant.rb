class AddProcessingTimeToVariant < ActiveRecord::Migration
  def change
    add_column :spree_variants, :processing_days, :integer, default: 1
  end
end
