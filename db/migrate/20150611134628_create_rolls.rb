class CreateRolls < ActiveRecord::Migration
  def change
    create_table :rolls do |t|
      t.references :trip, index: true
      t.references :player_group, index: true
      t.integer :modifier
      t.integer :raw_value

      t.timestamps
    end
  end
end
