#install.packages(c("shiny", "datasets",'shinydashboard','DT','GGally','tm','wordcloud','memoise','ggmap','dplyr','ggplot2','WDI','countrycode','forcats','rworldmap'))
library(tm)
library(wordcloud)
library(memoise)
library(ggmap)
library(dplyr)
library(ggplot2)
library("WDI") 

airline = read.csv('airline.csv')
airport = read.csv('airport.csv')

##data wrangling
#aggregate data
wanted_airline = names(airline) %in% 
  c('overall_rating','seat_comfort_rating','cabin_staff_rating','food_beverages_rating','inflight_entertainment_rating','ground_service_rating','wifi_connectivity_rating','value_money_rating','recommended')
airline_agg = aggregate(airline[wanted_airline], by = list(airline$airline_name), FUN = mean, na.rm = TRUE, drop = TRUE)
airline_count = airline %>%
  group_by(airline$airline_name) %>%
  tally()
airline_agg = merge(airline_agg, airline_count, by.x = 'Group.1', by.y='airline$airline_name')

wanted_airport = names(airport) %in% 
  c('overall_rating','queuing_rating','terminal_cleanliness_rating','terminal_seating_rating','terminal_signs_rating','food_beverages_rating','airport_shopping_rating','wifi_connectivity_rating','airport_staff_rating','recommended')
airport_agg = aggregate(airport[wanted_airport], by = list(airport$airport_name), FUN = mean, na.rm = TRUE, drop = TRUE)
airport_count = airport %>%
  group_by(airport$airport_name) %>%
  tally()
airport_agg = merge(airport_agg, airport_count, by.x = 'Group.1', by.y='airport$airport_name')

##update country code for map plotting
library(countrycode)
country = data.frame(countrycode(airline$author_country,'country.name','iso3c'))
colnames(country) = "ISO3"
airline = data.frame(airline , country)

country = data.frame(countrycode(airport$author_country,'country.name','iso3c'))
colnames(country) = "ISO3"
airport = data.frame(airport , country)

##retrieve the income/GPD data from worldbank.org by WDI lilbrary
#merge with World bank data
library("WDI")
wdi_gdp <- WDI(country = "all", indicator = "NY.GDP.PCAP.CD",start = 2016, end = 2016, extra = TRUE, cache = NULL) %>%
  mutate(gdp2016 = NY.GDP.PCAP.CD,
         capital_lon = as.numeric(paste(longitude)), #factor to numeric
         capital_lat = as.numeric(paste(latitude))) %>%
  select(iso3c, country, gdp2016, capital, capital_lon, capital_lat, income, region)

airport = merge(airport, wdi_gdp, by.x = 'ISO3', by.y = 'iso3c')
airline = merge(airline, wdi_gdp, by.x = 'ISO3', by.y = 'iso3c')


###variables for panel options
dataset <<- list("Airport review" = "airport",
                "Airline review" = "airline"
               )
map_choice <<- list("income" = "income",
                    "GDP" = "gdp2016"
                )
show_att_1 <<- c('airline_name', 'cabin_flown','overall_rating','recommended') 
show_att_2 <<- c('airport_name','overall_rating','recommended')

#Word Cloud: "memoise" automatically cache the results
getTermMatrix <- memoise(function(selection,size) {
  # Careful not to let just any name slip in here; a
  # malicious user could manipulate this value.
  
  text <- get(selection)$content[1:size]
  
  myCorpus = Corpus(VectorSource(text))
  myCorpus = tm_map(myCorpus, content_transformer(tolower))
  myCorpus = tm_map(myCorpus, removePunctuation)
  myCorpus = tm_map(myCorpus, removeNumbers)
  myCorpus = tm_map(myCorpus, removeWords,
                    c(stopwords("SMART"), "thy", "thou", "thee", "the", "and", "but"))
  
  myDTM = TermDocumentMatrix(myCorpus,
                             control = list(minWordLength = 1))
  
  m = as.matrix(myDTM)
  
  sort(rowSums(m), decreasing = TRUE)
})

#ggplot map drawing
draw_gdp = function() {
  wdi_gdp <- WDI(country = "all", indicator = "NY.GDP.PCAP.CD",start = 2016, end = 2016, extra = TRUE, cache = NULL) 
  
  
  wdi_gdp <- wdi_gdp %>%
    mutate(gdp2016 = NY.GDP.PCAP.CD,
           capital_lon = as.numeric(paste(longitude)), #factor to numeric
           capital_lat = as.numeric(paste(latitude))) %>%
    select(iso3c, country, gdp2016, capital, capital_lon, capital_lat, income, region)
  
  #add map data by ISO3
  library("rworldmap")
  gdp_map <- joinCountryData2Map(wdi_gdp, joinCode = "ISO3", nameJoinColumn = "iso3c")
  
  gdp_map_poly = fortify(gdp_map)
  gdp_map_poly = merge(gdp_map_poly, gdp_map@data, by.x='id', by.y='ADMIN', all.x = TRUE) %>% 
    arrange(id, order) %>%
    select(id, long, lat, country, gdp2016, income, group, capital_lon, capital_lat)
  
  gdp_map_poly$income <- factor(gdp_map_poly$income, levels=c('High income','Upper middle income','Lower middle income','Low income'))
  return(gdp_map_poly)
  #gdp_map_poly = gdp_map_poly[complete.cases(gdp_map_poly),]
}

#Bar chart for overall rating

#airport data output function (returning a dataset for charting)
rating_data = function(top_bottom = 'Top'){

  #plot
  library(forcats)
  data_plot = airport_agg[order(airport_agg$overall_rating, decreasing = TRUE),] #Sort by overall_rating
  
  # top_bottom = 'Top'
  sample_size = 79 #airport = 79 ; airline = 110
  # n=15
  if (top_bottom == 'Top') {
    decrease = TRUE
    show_color = 'lightskyblue3'
  } else {
    decrease = FALSE
    show_color = 'pink'
  }
  
  #data_plot = airline_agg[order(airline_agg$overall_rating, decreasing = decrease),] #Sort by overall_rating
  data_plot = airport_agg[order(airport_agg$overall_rating, decreasing = decrease),] #Sort by overall_rating
  data_plot = filter(data_plot, n>sample_size) #reduce outliers
  # data_plot = data_plot[1:15,] #top data selected
  
  if (top_bottom == 'Top') {  order = data_plot$overall_rating 
  } else {  order = -data_plot$overall_rating }
  
  
return(data_plot)
}

 #airline (function to return a dataset)
rating_data_airline = function(top_bottom = 'Top'){
  
  #plot
  library(forcats)
  data_plot_airline = airline_agg[order(airline_agg$overall_rating, decreasing = TRUE),] #Sort by overall_rating
  # top_bottom = 'Top'
  sample_size = 110 #airport = 79 ; airline = 110
  # n=15
  # if (top_bottom == 'Top') {
  #   decrease = TRUE
  #   show_color = 'lightskyblue3'
  # } else {
  #   decrease = FALSE
  #   show_color = 'pink'
  # }
  # 
  data_plot_airline = airline_agg[order(airline_agg$overall_rating, decreasing = decrease),] #Sort by overall_rating
  data_plot_airline = filter(data_plot_airline, n>sample_size) #reduce outliers
  # data_plot_airline = data_plot_airline[1:15,] #top data selected
  
  if (top_bottom == 'Top') {  order = data_plot_airline$overall_rating 
  } else {  order = -data_plot_airline$overall_rating }
  
  
  return(data_plot_airline)
}

