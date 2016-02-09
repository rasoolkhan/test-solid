class CreateSpreeProductFeatures < ActiveRecord::Migration
  def change
    create_table :spree_product_features do |t|
      t.integer :product_id
      t.text :description_line
    end
    add_index :spree_product_features, :product_id
  end
end
