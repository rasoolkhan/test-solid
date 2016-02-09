class CreateSpreePayuInPayments < ActiveRecord::Migration
  def change
    create_table :spree_payu_in_payments do |t|
      t.integer :payment_method_id
      t.integer :user_id
      t.references :address
      t.string :mihpayid
      t.string :mode
      t.string :status
      t.string :responseHash
      t.string :error
      t.string :error_message
      t.string :bankcode
      t.string :pg_type
      t.string :bank_ref_num
      t.string :unmappedstatus
      t.string :name_on_card
      t.string :cardnum
      t.string :issuing_bank
      t.string :card_type
      t.string :verifyHash
    end
    add_index :spree_payu_in_payments, :payment_method_id
    add_index :spree_payu_in_payments, :user_id
  end
end
