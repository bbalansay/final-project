library(shiny)
library(ggplot2)


drug.data <- read.csv("data/drug-use.csv", stringsAsFactors = FALSE)





server <- function(input, output) {
  
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
}  

shinyServer(server)