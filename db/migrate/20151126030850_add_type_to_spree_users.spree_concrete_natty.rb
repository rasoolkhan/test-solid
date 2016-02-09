# This migration comes from spree_concrete_natty (originally 20150826125357)
class AddTypeToSpreeUsers < ActiveRecord::Migration
  def change
  	add_column :spree_users, :user_type, :integer
  end
end
