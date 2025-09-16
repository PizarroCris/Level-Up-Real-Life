class AddColumnsToBattle < ActiveRecord::Migration[7.1]
  def change
    add_reference :battles, :winner, null: false, foreign_key: { to_table: :profiles }
    add_column :battles, :battle_log, :text
  end
end
