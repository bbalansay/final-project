
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
  output$weedTime <-renderPlot({
    
    
    drug.use <-paste0(input$drug_choice, ".use")
    
    drug.data.filtered <- select(drug.data, age, drug.use) %>%
      filter( age > input$`Minimum Age Group`) %>%
      filter(age < input$`Maximum Age Group`)
    
    geom_bar(stat="identity")
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
      labs(title = "Drug use percentage by Age in 2012", 
           x = "Drugs",
           y = "Usage (%)") +
      coord_flip()
    
    return(bar.plot)
    
  })
  
}

shinyServer(server)