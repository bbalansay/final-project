library("shiny")
library("dplyr")
drug.data <- read.csv("data/drug-use.csv", stringsAsFactors = FALSE)

###############################################################################
#                                                                             #
#  I've set the UI up so that each data visualization has its own tab.        #
#                                                                             #
#  Each tab also has its own set of items in the sidebar. The summary tab     #
#  an overall description of the project. Plots 1 and 2 should use the same   #
#  widgets, as they use the same CSV and the data they use complement each    #
#  other. The last tab uses the Connecticut data and can do whatever.         #
#                                                                             #
#  Make sure that the graphs aren't too different from each other: try to     #
#  have similar color schemes, and plots 1 and 2 should use the same type     #
#  of graph.                                                                  #
#                                                                             #
###############################################################################


ui <- fluidPage(
  titlePanel("Drug Use And Abuse"),
  h5(style = "padding-left:1em;",
     "An INFO 201 group project by Bradley Balansay, Sam Chiang, Pranav Kartha, and McKinley Harvey"),
  hr(),
  
  sidebarPanel(
    
    ##################################################
    #  For the summary data, put sidebar stuff here  #
    ##################################################
    conditionalPanel(
      condition = "input.dataTabs == 'Summary'",
      h3("The Data")
    ),
    
    #####################################################################
    #  Agree on the widgets for plot 1/2 (use and freq), put them here  #
    #####################################################################
    conditionalPanel(
      condition = "input.dataTabs == 'Plot1' | input.dataTabs == 'Plot2'",
      h3('Plot1/2')
    ),
    
    ##################################################################
    #  Whatever is used for the Connecticut stuff, put widgets here  #
    ##################################################################
    conditionalPanel(
      condition = "input.dataTabs == 'Effects'",
      h3('Effects')
    )
    
  ),
  
  sliderInput( "Year",
               "Year:",
               value = 16,
               min = 1998,
               max = 2014),
  
  selectInput("drug_choice", label = h3("Select a drug to analyze"), 
              choices = c("alcohol", "marijuana", "cocaine", "crack" , "heroin", "hallucinogen", 
                          "inhalant", "pain.reliever", "oxycontin", "tranquilizer", "stimulant",
                          "meth", "sedative"), 
              selected = 1),
  
  
  selectInput("Minimum Age Group", label = h3("Minimum Age Group"), 
              choices = drug.data$age, 
              selected = 1),
  
  selectInput("Maximum Age Group", label = h3("Maximum Age Group"), 
              choices = drug.data$age, 
              selected = 1),
 
  mainPanel(
    tabsetPanel(type = "tabs", id = "dataTabs",
                
                #########################
                #  Tab for the Summary  #
                #########################
                tabPanel("Summary",plotOutput("weedTime"),
                         h3("Summary"),
                         br(), p("Summary")),
                
                ##########################
                #  Tab for Plot 1 (Use)  #
                ##########################
                tabPanel("Plot1", 
                         h3("Plot 1"),
                         br(), p("Plot 1")),
                
                ################################
                #  Tab for Plot 2 (Frequency)  #
                ################################
                tabPanel("Plot2",
                         h3("Drug Use vs. Age Group"),
                         br(), p("Plot 2")),
                
                ##############################
                #  Tab for Connecticut Data  #
                ##############################
                tabPanel("Effects", 
                         h3("Effects"),
                         br(), p("Effects"))
    )
  )
)

shinyUI(ui)