class ChangeProductPrice < ActiveRecord::Migration
  def change
    change_column :products, :price, :float
  end
end
