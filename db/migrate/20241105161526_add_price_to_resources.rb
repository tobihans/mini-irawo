class AddPriceToResources < ActiveRecord::Migration[7.2]
  def change
    add_column :resources, :price, :integer
  end
end
