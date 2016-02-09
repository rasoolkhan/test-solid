# This migration comes from spree_concrete_natty (originally 20150810102048)
class AddSalePriceToSpreeVariants < ActiveRecord::Migration
  def change
    add_column :spree_variants, :sale_price, :decimal, :precision => 8, :scale => 2 
  end
end
