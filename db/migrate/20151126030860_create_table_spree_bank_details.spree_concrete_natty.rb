# This migration comes from spree_concrete_natty (originally 20150902120624)
class CreateTableSpreeBankDetails < ActiveRecord::Migration
  def change
    create_table :spree_bank_details do |t|
    	t.belongs_to :seller, index: true
    	t.string :bank_name
    	t.string :branch
    	t.string :account_number
    	t.string :ifsc
    end
  end
end
