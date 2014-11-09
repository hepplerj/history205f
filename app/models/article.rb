class Article < ActiveRecord::Base
	has_and_belongs_to_many :locations
	has_and_belongs_to_many :organizations
	has_and_belongs_to_many :people
	has_and_belongs_to_many :subjects
end