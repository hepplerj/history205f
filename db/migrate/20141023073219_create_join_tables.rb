class CreateJoinTables < ActiveRecord::Migration
  def change
  	create_table :articles_locations, id: false do |t|
  		t.integer :article_id
  		t.integer :location_id
  	end

  	create_table :articles_people, id:false do |t|
  		t.integer :article_id
  		t.integer :person_id
  	end

  	create_table :articles_subjects, id:false do |t|
  		t.integer :article_id
  		t.integer :subject_id
  	end

  	create_table :articles_organizations, id:false do |t|
  		t.integer :article_id
  		t.integer :organization_id
  	end
  end
end
