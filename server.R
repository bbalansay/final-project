
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
        labs(title = paste(titles, "When Compared with", input$fill))
      } 
  })
  
  output$intro <- renderText({
    "This data set contains information on accidental 
    deaths by drug overdoses from the years 2012 to 
    2017 in the state of Connecticut. The types of drugs 
    found in bodies included heroin, cocaine, fentanyl, 
    oxycodone, oxymorphone, and more. Marijauana is not 
    included as there have been no cases where marijauna 
    was the immediate cause of death. It appears that heroin 
    was one of the most used drugs that lead to death with 
    54% of bodies found contained this drug. 28% of bodies 
    were found to have some amount of cocaine and 31% of 
    bodies were found to have contained at least some fentanyl." 
    
  })
  
  output$analysis <- renderText({
    if(input$fill == "Sex") {
        "It would be interesting to see how gender differs between these deaths. 
      From 2012 to 2017, there were many more men who died from drug overdose. 
      In fact, only 27% of the bodies were female. The data show that many more 
      men die every year than women. In addition, very young people (ie less than 
      20 years old) and older people (ie greater than 60 years) show fewer counts 
      for accidental overdoses. It would be interesting to read studies as to why 
      males are more likely to die from overdose than females and how to prevent 
      these deaths."
     
    } else {
      "Furthermore, it is interesting to look at where people die as well. 
      The vast majorities of these deaths seem to have been taken place in 
      some residence (52%), with the next most location of deaths being in 
      hospitals (33%). This suggests that people may take the drug at home 
      and then travel to the hospital in hopes of treatment for an overdose 
      before succumbing to death. It appears that throughout age, hospitals 
      and residences are the most common places people die from accidental 
      drug overdoses, which makes sense."
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
  
  # outputs a bar graph displaying frequency of drug use across different age groups
  output$weedTime <-renderPlot({
    
    # gets drug choice from user inout
    drug.use <- paste0(input$drug_choice, ".use")
    
    # filters out data not in the data range from the graph. 
    drug.data.filtered <- select(drug.data, age, drug.use) %>%
      filter(age >= input$min.age) %>%
      filter(age <= input$max.age)
    
    
    # depending on which drug is chosen, the app will choose the approrpiate
    # aesthetics for the bar graph, and graph accordingly. 
    if(input$drug_choice == "alcohol") {
      age.graph <- ggplot(data=drug.data.filtered, aes(x=age, y=alcohol.use)) +
        geom_bar(stat="identity", aes(fill = age))
    } else if (input$drug_choice == "marijuana") {
      age.graph <- ggplot(data=drug.data.filtered, aes(x=age, y=marijuana.use)) +
        geom_bar(stat="identity", aes(fill = age))
    } else if (input$drug_choice == "cocaine") {
      age.graph <- ggplot(data=drug.data.filtered, aes(x=age, y=cocaine.use)) +
        geom_bar(stat="identity", aes(fill = age))
    } else if (input$drug_choice == "crack") {
      age.graph <- ggplot(data=drug.data.filtered, aes(x=age, y=crack.use)) +
        geom_bar(stat="identity", aes(fill = age))
    } else if (input$drug_choice == "heroin") {
      age.graph <- ggplot(data=drug.data.filtered, aes(x=age, y=heroin.use)) +
        geom_bar(stat="identity", aes(fill = age))
    } else if (input$drug_choice == "hallucinogen") {
      age.graph <- ggplot(data=drug.data.filtered, aes(x=age, y=hallucinogen.use)) +
        geom_bar(stat="identity", aes(fill = age))
    } else if (input$drug_choice == "inhalant") {
      age.graph <- ggplot(data=drug.data.filtered, aes(x=age, y=inhalant.use)) +
        geom_bar(stat="identity", aes(fill = age))
    } else if (input$drug_choice == "pain.reliever") {
      age.graph <- ggplot(data=drug.data.filtered, aes(x=age, y=pain.reliever.use)) +
        geom_bar(stat="identity", aes(fill = age))
    } else if (input$drug_choice == "oxycontin") {
      age.graph <- ggplot(data=drug.data.filtered, aes(x=age, y=oxycontin.use)) +
        geom_bar(stat="identity", aes(fill = age))
    } else if (input$drug_choice == "tranquilizer") {
      age.graph <- ggplot(data=drug.data.filtered, aes(x=age, y=tranquilizer.use)) +
        geom_bar(stat="identity", aes(fill = age))
    } else if (input$drug_choice == "stimulant") {
      age.graph <- ggplot(data=drug.data.filtered, aes(x=age, y=stimulant.use)) +
        geom_bar(stat="identity", aes(fill = age))
    } else if (input$drug_choice == "meth") {
      age.graph <- ggplot(data=drug.data.filtered, aes(x=age, y=meth.use)) +
        geom_bar(stat="identity", aes(fill = age))
    } else if (input$drug_choice == "sedative") {
      age.graph <- ggplot(data=drug.data.filtered, aes(x=age, y=sedative.use)) +
        geom_bar(stat="identity", aes(fill = age))
    }
    
    #plots graph
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