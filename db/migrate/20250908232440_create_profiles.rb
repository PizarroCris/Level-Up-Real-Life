class CreateProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :username, null: false
      t.integer :attack, default: Profile::DEFAULT_ATTACK
      t.integer :defense, default: Profile::DEFAULT_DEFENSE
      t.integer :steps, default: 0
      t.integer :wood, default: 500
      t.integer :stone, default: 500
      t.integer :metal, default: 500
      t.integer :level, default: 1
      t.integer :experience, default: 0, null: false

      t.timestamps
    end
  end
end
