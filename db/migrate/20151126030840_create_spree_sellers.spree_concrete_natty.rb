# This migration comes from spree_concrete_natty (originally 20150812061721)
class CreateSpreeSellers < ActiveRecord::Migration
  def change
    create_table :spree_sellers do |t|
    	t.references :spree_user, index: true
    end
  end
end
