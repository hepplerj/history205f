class HomeController < ApplicationController
  def start
  end

  def get
  	startDate = Date.new(params[:startYear].to_i, 1, 1)
  	endDate = Date.new(params[:endYear].to_i, 12, 31)
  	searchType = params[:searchType]

    counter = Hash.new(0)
    records = []
    if (searchType == 'organizations')
        records = AggregateOrganizations.where("year >= ? AND year < ?", startDate, endDate)
    elsif searchType == 'locations'
        records = AggregateLocations.where("year >= ? AND year < ?", startDate, endDate)
    elsif searchType == 'keywords'
        records = AggregateKeywords.where("year >= ? AND year < ?", startDate, endDate)
    else  
        records = AggregatePeople.where("year >= ? AND year < ?", startDate, endDate)
    end

    records.each do |record|
      current = counter[record.name]
      counter[record.name] = current + record.articles
    end

  	mostFrequent = (counter.sort_by {|k, v| v}.reverse)[0..9]

    @finalData = {}
    mostFrequent.each do |topic|
        key = topic[0] + "|" + topic[1].to_s
        if (searchType == 'organizations')
            @finalData[key] = AggregateOrganizations.select("articles, year").where("year >= ? AND year < ? AND name = ?", startDate, endDate, topic[0])
        elsif searchType == 'locations'
            @finalData[key] = AggregateLocations.select("articles, year").where("year >= ? AND year < ? AND name = ?", startDate, endDate, topic[0])
        elsif searchType == 'keywords'
            @finalData[key] = AggregateKeywords.select("articles, year").where("year >= ? AND year < ? AND name = ?", startDate, endDate, topic[0])
        else  
            @finalData[key] = AggregatePeople.select("articles, year").where("year >= ? AND year < ? AND name = ?", startDate, endDate, topic[0])
        end
    end

  	render :json => @finalData
  end
end