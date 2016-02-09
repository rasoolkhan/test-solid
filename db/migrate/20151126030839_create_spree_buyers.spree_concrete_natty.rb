# This migration comes from spree_concrete_natty (originally 20150812061442)
class CreateSpreeBuyers < ActiveRecord::Migration
  def change
    create_table :spree_buyers do |t|
    	t.references :spree_user, index: true
    end
  end
end
