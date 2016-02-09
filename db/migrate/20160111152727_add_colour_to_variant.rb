class AddColourToVariant < ActiveRecord::Migration
  def change
    add_column :spree_variants, :colour, :string
  end
end
