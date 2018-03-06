library(shiny)

server <- function(input, output) {
  output$yearPlot <- renderPlot({
    titles <- paste("Number of Deaths By Age in", input$year)
    drug.deaths <- read.csv('data/Accidental_Drug_Related_Deaths__2012-June_2017-2.csv', 
                            stringsAsFactors = FALSE) %>% 
      filter(Race != "", Date != "", Age != "", Sex != "", Location != "")
    year.deaths <- drug.deaths[substr(drug.deaths$Date, 7, 10) == input$year, ] 
    if(input$fill == "Sex") {
      ggplot(data = year.deaths) +
        geom_bar(mapping = aes(x = Age, fill = Sex)) +
        labs(title = paste(titles, "When Compared with", input$fill))
    } else if (input$fill == "Location") {
      ggplot(data = year.deaths) +
        geom_bar(mapping = aes(x = Age, fill = Location)) +
        labs(title = paste(titles, "When Compared with", input$fill))
    } else {
      ggplot(data = year.deaths) +
        geom_bar(mapping = aes(x = Age)) +
        labs(title = titles)
        
    }
    
  })
  
}

shinyServer(server)