# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'spreadsheet'
require 'date'

AggregateOrganizations.new(name: "yes", articles: 6, year: Date.new(1970, 1, 1))

Spreadsheet.client_encoding = 'UTF-8'
book = Spreadsheet.open 'db/times data cleaned.xls'
sheet = book.worksheet 0

row = sheet.row(1)

sheet.each 1 do |row|
	date = row[16]
	a = Article.create(headline: row[5], byline: row[13], snippet: row[1], 
				lead_paragraph: row[2], abstract: row[3], URL: row[0],
				date: Date.parse(date[0..9]))

	organizationsString = row[7]
	if not organizationsString.nil?
		organizations = organizationsString.split(';')
		organizations.each do |organization|
			o = Organization.create(name: organization)
			a.organizations << o
		end
	end

	peopleString = row[6]
	if not peopleString.nil?
		people = peopleString.split(';')
		people.each do |person|
			p = Person.create(name: person)
			a.people << p
		end
	end

	locationsString = row[8]
	if not locationsString.nil?
		locations = locationsString.split(';')
		locations.each do |location|
			l = Location.create(name: location)
			a.locations << l
		end
	end

	subjectsString = row[9]
	if not subjectsString.nil?
		subjects = subjectsString.split(';')
		subjects.each do |subject|
			s = Subject.create(name: subject)
			a.subjects << s
		end
	end
end

start = Date.new(1970, 1, 1)
last = Date.new(1971, 1, 1)

while start < Date.new(2014, 10, 10) do
	counter = Hash.new(0)

	Article.where("date < ? AND date > ?", last, start).each do |article|
		article.organizations.each do |element|
			current = counter[element.name]
			counter[element.name] = current + 1
		end
	end

	counter.each do |key, value|
		AggregateOrganizations.create(name: key, articles: value, year: start)
	end

	start = start + 365
	last = last + 365
end

start = Date.new(1970, 1, 1)
last = Date.new(1971, 1, 1)

while start < Date.new(2014, 10, 10) do
	counter = Hash.new(0)

	Article.where("date < ? AND date > ?", last, start).each do |article|
		article.people.each do |element|
			current = counter[element.name]
			counter[element.name] = current + 1
		end
	end

	counter.each do |key, value|
		AggregatePeople.create(name: key, articles: value, year: start)
	end

	start = start + 365
	last = last + 365
end

start = Date.new(1970, 1, 1)
last = Date.new(1971, 1, 1)

while start < Date.new(2014, 10, 10) do
	counter = Hash.new(0)

	Article.where("date < ? AND date > ?", last, start).each do |article|
		article.locations.each do |element|
			current = counter[element.name]
			counter[element.name] = current + 1
		end
	end

	counter.each do |key, value|
		AggregateLocations.create(name: key, articles: value, year: start)
	end

	start = start + 365
	last = last + 365
end

start = Date.new(1970, 1, 1)
last = Date.new(1971, 1, 1)

while start < Date.new(2014, 10, 10) do
	counter = Hash.new(0)

	Article.where("date < ? AND date > ?", last, start).each do |article|
		article.subjects.each do |element|
			current = counter[element.name]
			counter[element.name] = current + 1
		end
	end

	counter.each do |key, value|
		AggregateKeywords.create(name: key, articles: value, year: start)
	end

	start = start + 365
	last = last + 365
end