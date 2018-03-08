
source("drug-vars.R")

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
        labs(title = paste(titles, "When Compared with", input$fill)) +
        scale_colour_manual(values = c("Hospital" = "dark green", "Residence" = "red", "Hospice" = "dark blue", "Other" = "yellow"))
    } else {
      ggplot(data = year.deaths) +
        geom_bar(mapping = aes(x = Age)) +
        labs(title = titles)
        
    }
    
  })
  
  output$plot <- renderPlot({
    
    filtered.data <- filter(drug.long.freq, age == input$Age)
    
    bar.plot <- ggplot(filtered.data, aes(x = filtered.data$drugs, y = filtered.data$values)) +
      geom_bar(stat = "identity", aes(fill = drugs)) +
      labs(title = "Drug Frequency By Age In 2012", 
           x = "Drugs",
           y = "Median amounts of usage") +
      coord_flip()
    
    return(bar.plot)
    
  })
  output$weedTime <-renderPlot({
    
    
    drug.use <-paste0(input$drug_choice, ".use")
    
    drug.data.filtered <- select(drug.data, age, drug.use) %>%
      filter( age > input$`Minimum Age Group`) %>%
      filter(age < input$`Maximum Age Group`)
    
    geom_bar(stat="identity", aes(fill = drugs))
    if(input$drug_choice == "alcohol") {
      age.graph <- ggplot(data=drug.data.filtered, aes(x=age, y=alcohol.use)) +
        geom_bar(stat="identity")
    } else if (input$drug_choice == "marijuana") {
      age.graph <- ggplot(data=drug.data.filtered, aes(x=age, y=marijuana.use)) +
        geom_bar(stat="identity")
    }else if (input$drug_choice == "cocaine") {
      age.graph <- ggplot(data=drug.data.filtered, aes(x=age, y=cocaine.use)) +
        geom_bar(stat="identity")
    }  else if (input$drug_choice == "crack") {
      age.graph <- ggplot(data=drug.data.filtered, aes(x=age, y=crack.use)) +
        geom_bar(stat="identity")
    }
    
    else if (input$drug_choice == "heroin") {
      age.graph <- ggplot(data=drug.data.filtered, aes(x=age, y=heroin.use)) +
        geom_bar(stat="identity")
    }
    
    else if (input$drug_choice == "hallucinogen") {
      age.graph <- ggplot(data=drug.data.filtered, aes(x=age, y=hallucinogen.use)) +
        geom_bar(stat="identity")
    }
    
    else if (input$drug_choice == "inhalant") {
      age.graph <- ggplot(data=drug.data.filtered, aes(x=age, y=inhalant.use)) +
        geom_bar(stat="identity")
    }
    else if (input$drug_choice == "pain.reliever") {
      age.graph <- ggplot(data=drug.data.filtered, aes(x=age, y=pain.reliever.use)) +
        geom_bar(stat="identity")
    }
    else if (input$drug_choice == "oxycontin") {
      age.graph <- ggplot(data=drug.data.filtered, aes(x=age, y=oxycontin.use)) +
        geom_bar(stat="identity")
    }
    else if (input$drug_choice == "tranquilizer") {
      age.graph <- ggplot(data=drug.data.filtered, aes(x=age, y=tranquilizer.use)) +
        geom_bar(stat="identity")
    }  else if (input$drug_choice == "stimulant") {
      age.graph <- ggplot(data=drug.data.filtered, aes(x=age, y=stimulant.use)) +
        geom_bar(stat="identity")
    } else if (input$drug_choice == "meth") {
      age.graph <- ggplot(data=drug.data.filtered, aes(x=age, y=meth.use)) +
        geom_bar(stat="identity")
    } else if (input$drug_choice == "sedative") {
      age.graph <- ggplot(data=drug.data.filtered, aes(x=age, y=sedative.use)) +
        geom_bar(stat="identity")
    }
    plot(age.graph)
    return(age.graph)
  })
  
  output$plot2 <- renderPlot({
    
    filtered.data <- filter(drug.long.use, age == input$Age)
    
    bar.plot <- ggplot(filtered.data, aes(x = filtered.data$drugs, y = filtered.data$values)) +
      geom_bar(stat = "identity", aes(fill = drugs)) +
      labs(title = "Drug Use Percentage By Age In 2012", 
           x = "Drugs",
           y = "Usage (%)") +
      coord_flip()
    
    return(bar.plot)
    
  })
  
}

shinyServer(server)