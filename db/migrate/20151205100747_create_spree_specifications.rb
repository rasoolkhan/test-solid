class CreateSpreeSpecifications < ActiveRecord::Migration
  def change
    create_table :spree_specifications do |t|
      t.integer :product_id
      t.text :spec
    end
    add_index :spree_specifications, :product_id
  end
end
