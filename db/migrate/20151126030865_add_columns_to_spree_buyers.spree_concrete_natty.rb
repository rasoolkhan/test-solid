# This migration comes from spree_concrete_natty (originally 20150908053451)
class AddColumnsToSpreeBuyers < ActiveRecord::Migration
  def change
  	add_column :spree_buyers,:phone_number, :string
  	add_column :spree_buyers, :name, :string
  end
end
