library(shiny)

server <- function(input, output) {
  output$yearPlot <- renderPlot({
    drug.deaths <- read.csv('data/Accidental_Drug_Related_Deaths__2012-June_2017-2.csv', 
                            stringsAsFactors = FALSE) %>% 
      filter(Race != "", Date != "", Age != "", Sex != "", Location != "")
    year.deaths <- drug.deaths[substr(drug.deaths$Date, 7, 10) == input$year, ] 
    if(input$fill == "Sex") {
      ggplot(data = year.deaths) +
        geom_bar(mapping = aes(x = Age, fill = Sex))
    } else if (input$fill == "Location") {
      ggplot(data = year.deaths) +
        geom_bar(mapping = aes(x = Age, fill = Location))
    } else {
      ggplot(data = year.deaths) +
        geom_bar(mapping = aes(x = Age))
    }
    
  })
}

shinyServer(server)