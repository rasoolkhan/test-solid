# This migration comes from spree_concrete_natty (originally 20151016102113)
class CreateSpreeNattyPick < ActiveRecord::Migration
  def change
    create_table :spree_natty_picks do |t|
    	t.integer :taxon_id
    end
  end
end
