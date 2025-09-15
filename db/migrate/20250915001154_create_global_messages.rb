class CreateGlobalMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :global_messages do |t|
      t.references :profile, null: false, foreign_key: true
      t.text :content, null: false

      t.timestamps
    end
  end
end
