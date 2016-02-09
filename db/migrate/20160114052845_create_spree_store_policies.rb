class CreateSpreeStorePolicies < ActiveRecord::Migration
  def change
    create_table :spree_store_policies do |t|
      t.integer :store_id
      t.string :heading
      t.text :description
    end
    add_index :spree_store_policies, :store_id
  end
end
