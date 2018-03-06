source("drug-vars.R")

server <- function(input, output) {
  
  output$plot <- renderPlot({
    
    filtered.data <- filter(drug.long.freq, age == input$Age)
    
    bar.plot <- ggplot(filtered.data, aes(x = filtered.data$drugs, y = filtered.data$values)) +
      geom_bar(stat = "identity", aes(fill = drugs)) +
      labs(title = "Drug Frequency by Age in 2012", 
           x = "Drugs",
           y = "Median amounts of usage") +
      coord_flip()
    
    return(bar.plot)
    
  })
  
  output$plot2 <- renderPlot({
    
    filtered.data <- filter(drug.long.use, age == input$Age)
    
    bar.plot <- ggplot(filtered.data, aes(x = filtered.data$drugs, y = filtered.data$values)) +
      geom_bar(stat = "identity", aes(fill = drugs)) +
      labs(title = "Drug use percentage by Age in 2012", 
           x = "Drugs",
           y = "Usage (%)") +
      coord_flip()
    
    return(bar.plot)
    
  })
  
}

shinyServer(server)