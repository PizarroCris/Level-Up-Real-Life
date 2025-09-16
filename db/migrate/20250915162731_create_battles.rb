class CreateBattles < ActiveRecord::Migration[7.1]
  def change
    create_table :battles do |t|
      t.references :attacker, null: false, foreign_key: { to_table: :profiles }
      t.references :defender, null: false, foreign_key: { to_table: :profiles }

      t.timestamps
    end
  end
end
