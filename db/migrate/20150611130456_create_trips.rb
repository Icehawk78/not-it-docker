class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.references :group, index: true
      t.text :description

      t.timestamps
    end
  end
end
