class AddHearaboutusToSpreeStores < ActiveRecord::Migration
  def change
    add_column :spree_stores, :hearaboutus, :text
  end
end
