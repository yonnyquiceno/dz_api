class ChangeProductPrice < ActiveRecord::Migration
  def change
    # change_column :products, :price, :decimal, precision: 10, scale: 2
    change_column :products, :price, :float
  end
end
