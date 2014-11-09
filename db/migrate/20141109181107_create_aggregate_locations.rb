class CreateAggregateLocations < ActiveRecord::Migration
  def change
    create_table :aggregate_locations do |t|
      t.string :name
      t.integer :articles
      t.date :year

      t.timestamps
    end
  end
end
