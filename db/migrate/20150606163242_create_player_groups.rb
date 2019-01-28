class CreatePlayerGroups < ActiveRecord::Migration
  def change
    create_table :player_groups do |t|
      t.references :group, index: true
      t.references :player, index: true
      t.integer :bank

      t.timestamps
    end
  end
end
