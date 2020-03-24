##install.packages(c("shiny", "datasets",'shinydashboard','DT','GGally','tm','wordcloud','memoise','ggmap','dplyr','ggplot2','WDI','countrycode','forcats','rworldmap'))
library(shinydashboard)
library(datasets)
library(shiny)

ui <- dashboardPage(
  skin = 'blue',
  
  dashboardHeader(title = 'Flight Satisfactory Study',titleWidth = 250),
  ## Sidebar content
  dashboardSidebar(
    width = 150,
    sidebarMenu(
      menuItem("Introduction", tabName = "intro", icon = icon("dashboard")),
      menuItem("Overall Rating", tabName = "rating", icon = icon("thumbs-up")),
      menuItem("Text data", tabName = "word", icon = icon("comment")),
      menuItem("Subgroup", tabName = "subgroup", icon = icon("globe")),
      menuItem("Dataset", tabName = "Dataset", icon = icon("th"))
    )
  ),
  
  
  
  dashboardBody(
    tabItems(
      #Introduction tab
      tabItem(tabName = 'intro', 
              titlePanel(title = 'Flight Satisfactory Study'),
              fluidPage(
                # title = 'Introduction',
                box(
                  title = "Introduction", width = 20, solidHeader = T,
                  "	In this era of technology, the world become closer and closer with the rise of aviation industry. According to the International Civil Aviation Organization (ICAO), there are 4.1 billion people, new record in 2017, taking advantages of the well-developed aviation service to travel all around the world. It becomes one of the most important transportation nowadays."
                ),
                box(
                  title = "Motivation", width = 20, solidHeader = T,
                  

                  h5("This project investigates the current air services situation, in terms of:"),
                  h5('1.	Rating of airlines and airports from travellers around the world'),
                  h5('2.	By what factors (e.g. comfortability, staff, food and beverage etc.) will drive the travellers’ judgement on the overall rating of the aviation service.'),
                  h5('3.	How does the background of travellers (i.e. origin country, region of world) will affect their satisfactory on air services?')
                  
                  
                )
              )),
      #second tab item
      tabItem(tabName = 'rating',
              fluidPage(
                titlePanel("Overall rating scored by travellers on Airports and Airlines"),
               
                # mainPanel(
                  tabsetPanel(
                    tabPanel('airport',
                             
                             box(h5('The bar chart below shows how travellers rate the airport. Airports in Asia stand out on the top 5 list, where Singapore Changi and Seoul Incheon airports are rated much more than the rest.'),
                                 h5('Here are some comments on these two airports:'),
                                 h6(em("Definitely the best airport in the world! Been there several times. Painless and quick passport clearance every time.   --- Review of Singapre Changi Airport in 2013")),
                                 h6(em("It was really clean modern and if you ever needed help there was always someone to help....   --- Review of Seoul Incheon Airport in 2015")),
                                 width = 12),
                             box(selectInput("type_airport",'Select type of rating:',
                                             choices = na.exclude(factor(names(rating_data()),exclude = c('Group.1','n'))),
                                             selected = 'overall_rating'),
                                 radioButtons("top_bottom", "Top/bottom:",
                                              choices = c('Top','Bottom'),
                                              selected = 'Top'),
                                 plotOutput("rating_bar_airport"),
                                 sliderInput("size_2",
                                             "No. of data shown:",
                                             min = 1,  max = 30,  value = 15),
                                 width = 12),
                             
                             box(h5('But what is the factors made the travellers rate about the airport? The correlation plot below shows the relationship between overall rating with other measures.'),
                                 h6('Note: The number inside each box represents the relationship between 2 attributes ranging from 1 to -1, where 1 is strongly positively related and 0 is unrelated.'),
                                 width = 12),
                             box('Correlation plot of all ratings',plotOutput('scatter_airport'),width = 12),
                             box(h5("When we focus on the last row (i.e. the relationship between overall rating with other measures), we can find that Airport Staff and Terminal Seating quality are key factors to travellers."),
                                 width = 12)
                    ),
                    tabPanel('airline',
                             
                             box(h5("Most of the top airlines are come from Asia from the graph below, where Asiana airlines, from South Korea, ranked number 1 among the travellers' reviews."),
                                 h5('Here are some comments:'),
                                 h6(em("This airlines 5 star status was reflected in all sectors the cabin crew were excellent. The food Western and Korean was delicious and delivered in a timely and unhurried manner.   --- Review of Asiana Airline in 2014")),
                                 h6(em("Check in very efficient and ground staff welcoming. Onboard service was excellent and the crew were incredibly accommodating.   --- Review of Asiana Airline in 2013")),
                                 width = 12),
                             box(selectInput("type_airline",'Select type of rating:',
                                             choices = na.exclude(factor(names(rating_data_airline()),exclude = c('Group.1','n','recommended'))),
                                             selected = 'overall_rating'),
                                 radioButtons("top_bottom_2", "Top/bottom:",
                                              choices = c('Top','Bottom'),
                                              selected = 'Top'),
                                 plotOutput("rating_bar_airline"),
                                 sliderInput("size_3",
                                             "No. of data shown:",
                                             min = 1,  max = 30,  value = 15),
                                 width = 12),
                             box(h5("The correlation plot below also reveals how each of the attributes related with the overall ratings (see the bottom row)."),width = 12),
                             box('Correlation plots of all ratings',plotOutput('scatter_airline'),width = 12),
                             box(h5("'Value money' shows the strongest relationship towards overall rating, revealing price is definitely top of travellers' mind. 'Cabin staff' and 'Ground service' come after 'value money' rating"),width = 12)
                    )
                  )
                # )
              )
      ),
     

      
      #third tab item
      tabItem(tabName = 'word',
              fluidPage(
                # Application title
                titlePanel("travellers' comments on airports/airlines"),
                
                sidebarLayout(
                  # Sidebar with a slider and selection inputs
                  sidebarPanel(
                    width = 4,
                    radioButtons("selection", "Choose a dataset:",
                                choices = dataset),
                    sliderInput("size",
                                "Size of data use:",
                                min = 1,  max = 15000,  value = 1000),
                    actionButton("update", "Change"),
                    hr(),
                    sliderInput("freq",
                                "Minimum Frequency of keywords:",
                                min = 1,  max = 300, value = 150),
                    sliderInput("max",
                                "Maximum Number of Words shown in the cloud:",
                                min = 1,  max = 300,  value = 100)
                  ),
                  
                  # Show Word Cloud
                  mainPanel(
                    box(h5("The word cloud below gives prominence to words that appear more frequently in travellers' comments.")
                        ,plotOutput("plot"),width = 12),
                    box(width = 12,
                        h4('Summary'),
                        h5('Airport data: Security, Time, Staff are clealy hot debates from travellers'),
                        h5('Airline data: Service, Seats, Crew, Time are key words from them.')
                        )
                  )
                )
              )
      ),
      
      # Fourth tab content
      tabItem(tabName = "subgroup",
              
              fluidPage(    
                
                # Give the page a title
                titlePanel("How does the background of travellers affect their overall ratings?"),
                box(h5('One of the possible reason that make passenger giving their score differently is due to their income level. The following violin charts are showing the scores splited by travellers from different income level of their origin country.'),width = 12),
                box(plotOutput('violin_airport'), width = 6),
                box(plotOutput('violin_airline'), width = 6),
                box(h5("It is not hard to observe from both violin charts that people with origin country from middle income tends to give a higher scores towards both airlines' and airports' services, while low income group scores the lowest."),
                    h5("One of the possible reason is due to their rating habbits or own cultures, i.e. they tend to rate the score higher. From the map below showing the distribution of country income level or GDP, we can observe that those airports and airlines are mostly in / from country that categorized as Middle income level, Asia, even though they may not visiting those labelled as 'High income' countries."),
                    h5("This may reveals that apart from the 'real' qualities of the airports or airlines, people giving out the rating may also be one of the bias when people judging how good or bad a airport/airline is."),width = 12),
                
                box(width = 12,
                    selectInput('selection_1','Options of statistics:', choices = map_choice),
                    helpText('Distribution over the world'),
                    plotOutput("mapplot"),
                    helpText('Data source: World Bank'))
              )
      ),
      # Last dataset tab
      tabItem(tabName = "Dataset",
              fluidPage(
                title = "Examples of DataTables",
                sidebarLayout(
                  sidebarPanel(
                    width = 3,
                    conditionalPanel( 
                      'input.dataset === "Airline"',
                      checkboxGroupInput("show_vars", "Columns in airline data to show:",
                                         names(airline), selected = show_att_1)
                    ),
                    conditionalPanel( 
                      'input.dataset === "Airport"',
                      checkboxGroupInput("show_vars_2", "Columns in airport data to show:",
                                         names(airport), selected = show_att_2)
                    )
                  ),
                  mainPanel(
                    tabsetPanel(
                      id = 'dataset',
                      tabPanel("Airline", DT::dataTableOutput("mytable1")),
                      tabPanel("Airport", DT::dataTableOutput("mytable2"))
                    )
                  )
                )
              )
            )
      
  

    )
  )
)
