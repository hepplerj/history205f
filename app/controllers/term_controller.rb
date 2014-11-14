class TermController < ApplicationController
  def explore
  	@startDate = Date.new(params[:startYear].to_i, 1, 1)
  	@endDate = Date.new(params[:endYear].to_i, 12, 31)
  	@searchType = params[:searchType]
  	@term = params[:term]

  	records = nil
  	if (@searchType == 'organizations')
        records = Organization.where("name = ?", @term)
    elsif @searchType == 'locations'
        records = Location.where("name = ?", @term)
    elsif @searchType == 'keywords'
        records = Subject.where("name = ?", @term)
    else  
        records = Person.where("name = ?", @term)
    end

    articlesWithTerm = []
    records.each do |record|
    	articlesWithTerm.push(*record.articles)
    end

    articlesWithinDates = Article.where("date >= ? AND date < ?", @startDate, @endDate)

    @articles = articlesWithTerm & articlesWithinDates
    @articles.shuffle!
  end
end
