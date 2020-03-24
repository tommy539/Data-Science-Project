##install.packages(c("shiny", "datasets",'shinydashboard','DT','GGally','tm','wordcloud','memoise','ggmap','dplyr','ggplot2','WDI','countrycode','forcats','rworldmap'))
library(datasets)
library(DT)

# Define a server for the Shiny app
function(input, output) {


  #dataset preview
  output$mytable1 <- DT::renderDataTable({
    withProgress({
      setProgress(message = "Processing data...")
      DT::datatable(airline[, input$show_vars, drop = FALSE])
    })
  })
  output$mytable2 <- DT::renderDataTable({
    withProgress({
      setProgress(message = "Processing data...")
      DT::datatable(airport[, input$show_vars_2, drop = FALSE])
    })
  })
  
  

  
  #map plot
  library(maps)
  library(mapproj)
  output$mapplot = renderPlot({
    ## progress showing
    withProgress({
      setProgress(message = "Processing map...")
    
    # map plot
    g= ggplot(draw_gdp()) +
      coord_map(xlim = c(-180, 180), ylim = c(-60, 75))  +
      geom_polygon(aes(x = long, y = lat, group = group,
                       fill=get(input$selection_1)) ,size = 0.3, na.rm = T)+
      labs(fill=input$selection_1)+
      theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())
    if (input$selection_1=='gdp2016') {
      g+ scale_fill_gradient(trans = "log",breaks=c(0,1000, 2000,5000,10000,25000,50000,100000), low="#f7fcb9", high="#2c7fb8") #+
    } else {
      g +scale_fill_manual( values=c("navy","blue","skyblue3", 'skyblue'), na.value = 'grey')#scale_fill_brewer(palette = "Set4")
      }
    })
  })
  
  #overall rating bar chart
  ## airport bar chart
  output$rating_bar_airport = renderPlot({
    
    if (input$top_bottom == 'Top') {
      decrease = TRUE
      show_color = 'lightskyblue3'
    } else {
      decrease = FALSE
      show_color = 'pink'
    }
      plot_data  = rating_data(input$top_bottom)[1:input$size_2,]
      
      ## progress bar
      dat <- data.frame(x = numeric(0), y = numeric(0))
      n = input$size_2
      withProgress(message = 'Making plot', value = 0, {
        # Number of times we'll go through the loop
        # n <- 10
        
        for (i in 1:n) {
          # Each time through the loop, add another row of data. This is
          # a stand-in for a long-running computation.
          dat <- rbind(dat, data.frame(x = rnorm(1), y = rnorm(1)))
          
          # Increment the progress bar, and update the detail text.
          incProgress(1/n, detail = paste("Doing part", i))
          
          # Pause for 0.1 seconds to simulate a long computation.
          Sys.sleep(0.1)
        }
      })
      
      ## plot
      ggplot(plot_data, mapping = aes(x= reorder(Group.1, get(input$type_airport) ), y = get(input$type_airport))) +
      geom_bar(stat="identity", fill=show_color) +
      coord_flip() +
      geom_text(aes(label=round(get(input$type_airport),2), vjust=0,hjust = -0.5),size = 3.5) +
      scale_y_continuous("Overall ratings",limits = c(0,10)) +
      scale_x_discrete('Airport')
    
    
    
  })
  ## airline bar chart
  output$rating_bar_airline = renderPlot({
    
    if (input$top_bottom_2 == 'Top') {
      decrease = TRUE
      show_color = 'lightskyblue3'
    } else {
      decrease = FALSE
      show_color = 'pink'
    }
    plot_data  = rating_data(input$top_bottom_2)[1:input$size_3,]
    
    ## progress bar
    dat <- data.frame(x = numeric(0), y = numeric(0))
    n = input$size_3
    withProgress(message = 'Making plot', value = 0, {
      # Number of times we'll go through the loop
      # n <- 10
      
      for (i in 1:n) {
        # Each time through the loop, add another row of data. This is
        # a stand-in for a long-running computation.
        dat <- rbind(dat, data.frame(x = rnorm(1), y = rnorm(1)))
        
        # Increment the progress bar, and update the detail text.
        incProgress(1/n, detail = paste("Doing part", i))
        
        # Pause for 0.1 seconds to simulate a long computation.
        Sys.sleep(0.1)
      }
    })
    
    ## plot
    ggplot(plot_data, mapping = aes(x= reorder(Group.1, get(input$type_airline) ), y = get(input$type_airline))) +
      geom_bar(stat="identity", fill=show_color) +
      coord_flip() +
      geom_text(aes(label=round(get(input$type_airline),2), vjust=0,hjust = -0.5),size = 3.5) +
      scale_y_continuous("Overall ratings",limits = c(0,10)) +
      scale_x_discrete('Airline')
    
    
    
  })
  
  #Word Cloud
  # Define a reactive expression for the document term matrix
  terms <- reactive({
    # Change when the "update" button is pressed...
    input$update
    # ...but not for anything else
    isolate({
      withProgress({
        setProgress(message = "Processing corpus...")
        getTermMatrix(input$selection, input$size)
      })
    })
  })
  
  # Make the wordcloud drawing predictable during a session
  wordcloud_rep <- repeatable(wordcloud)
  
  # wordcloud output
  output$plot <- renderPlot({
    v <- terms()
    wordcloud_rep(names(v), v, scale=c(4,0.5),
                  min.freq = input$freq, max.words=input$max,
                  colors=brewer.pal(8, "Dark2"))
  })  

  #violin plot 
  output$violin_airport = renderPlot({
    ###Violin chart
    ggplot(airport, aes(x = airport$income, y = airport$overall_rating))+
      geom_violin(trim=F, na.rm = T, fill='#A4A4A4', color="darkred")+
      geom_boxplot(width=0.1, na.rm = T)+
      scale_x_discrete(limits=c("High income","Upper middle income",'Lower middle income',"Low income"))+
      labs(title="Overall rating on airport by income group",x="Income group", y = "Overall rating")+
      theme_linedraw()
  })
  output$violin_airline = renderPlot({
    ###Violin chart
    ggplot(airline, aes(x = airline$income, y = airline$overall_rating))+
      geom_violin(trim=F, na.rm = T, fill='#A4A4A4', color="darkred")+
      geom_boxplot(width=0.1, na.rm = T)+
      scale_x_discrete(limits=c("High income","Upper middle income",'Lower middle income',"Low income"))+
      labs(title="Overall rating on airline by income group",x="Income group", y = "Overall rating")+
      theme_linedraw()
  })
  
  #scatter plot 
  output$scatter_airport = renderPlot({
    library(GGally)
    ggcorr(airport[,12:21], nbreaks=11, palette='RdBu', label=TRUE, label_size=5, label_color='white', size = 2.5,hjust=0.6)
    
  })
  output$scatter_airline = renderPlot({
    library(GGally)
    ggcorr(airline[,13:21], nbreaks=11, palette='RdBu', label=TRUE, label_size=5, label_color='white', size = 2.5,hjust=0.6)
    
  })

}
