// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .
  	function getSearchType() {
  		if ($("#organizations").is(':checked')) {
  			return 'organizations';
  		} else if ($("#people").is(':checked')) {
  			return 'people';
  		} else if ($("#keywords").is(':checked')) {
  			return 'keywords';
  		} else if ($("#locations").is(':checked')) {
  			return 'locations';
  		}
  	}

  	function update() {
  		searchType = getSearchType();
  		startYear = $( "#slider-range" ).slider( "values", 0 );
  		endYear = $( "#slider-range" ).slider( "values", 1 );

  		var myXHR = new XMLHttpRequest();
  		myXHR.open("GET", "/home/get?searchType=" + encodeURIComponent(searchType) + "&startYear=" + startYear + "&endYear=" + endYear);

    	myXHR.onreadystatechange = function() {
       		if (this.readyState != 4) {
           		return;
       		}
       		if (this.status == 200) {
              var topten = JSON.parse(this.responseText);

              var table = "<table class=\"table\"><tr><th>Name</th><th>Articles</th></tr>";
              for (var topic in topten) {
                var split = topic.split("|");
                table = table.concat("<tr><td>" + split[0] + "</td><td>" + split[1] + "</td></tr>");
              }

           		table = table.concat("</table>");
              $("#container").html(table);
           	} else {
           		console.log("Error.");
              $("#container").html("<h3>Insufficient data. Please try again.</h3>");
       		}
       	}	
        myXHR.send();
  	}