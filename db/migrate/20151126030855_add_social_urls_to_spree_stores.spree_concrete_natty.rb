# This migration comes from spree_concrete_natty (originally 20150827114827)
class AddSocialUrlsToSpreeStores < ActiveRecord::Migration
  def change
  	add_column :spree_stores, :social_urls, :string
  	add_column :spree_stores, :process_time, :string
  end
end
