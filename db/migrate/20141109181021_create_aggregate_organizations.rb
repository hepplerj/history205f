class CreateAggregateOrganizations < ActiveRecord::Migration
  def change
    create_table :aggregate_organizations do |t|
      t.string :name
      t.integer :articles
      t.date :year

      t.timestamps
    end
  end
end
