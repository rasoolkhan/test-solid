class AddBankingInfoToSellers < ActiveRecord::Migration
  def change
    add_column :spree_sellers, :bank_name, :string
    add_column :spree_sellers, :bank_branch, :string
    add_column :spree_sellers, :bank_address, :string
    add_column :spree_sellers, :bank_account_name, :string
    add_column :spree_sellers, :bank_account_number, :string
    add_column :spree_sellers, :bank_ifsc, :string
    add_column :spree_sellers, :bank_micr, :string
    add_column :spree_sellers, :bank_pan, :string
    add_column :spree_sellers, :bank_tin, :string
    add_column :spree_sellers, :bank_vat, :string
  end
end
