class CreateAggregateKeywords < ActiveRecord::Migration
  def change
    create_table :aggregate_keywords do |t|
      t.string :name
      t.integer :articles
      t.date :year

      t.timestamps
    end
  end
end
