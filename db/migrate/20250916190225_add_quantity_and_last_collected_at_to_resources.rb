class AddQuantityAndLastCollectedAtToResources < ActiveRecord::Migration[7.1]
  def change
    add_column :resources, :quantity, :integer, default: 0
    add_column :resources, :last_collected_at, :datetime
  end
end
