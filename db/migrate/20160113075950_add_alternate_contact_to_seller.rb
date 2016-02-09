class AddAlternateContactToSeller < ActiveRecord::Migration
  def change
    add_column :spree_sellers, :alternate_name, :string
    add_column :spree_sellers, :alternate_email, :string
    add_column :spree_sellers, :alternate_phone, :string
  end
end
