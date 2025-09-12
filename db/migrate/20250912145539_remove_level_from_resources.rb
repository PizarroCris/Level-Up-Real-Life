class RemoveLevelFromResources < ActiveRecord::Migration[7.1]
  def change
    remove_column :resources, :level, :integer
  end
end
