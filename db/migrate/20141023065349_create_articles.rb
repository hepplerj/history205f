class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :headline
      t.string :byline
      t.text :snippet
      t.text :lead_paragraph
      t.text :abstract
      t.string :URL
      t.date :date

      t.timestamps
    end
  end
end