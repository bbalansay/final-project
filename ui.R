library(shinythemes)
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

source("drug-vars.R")

ui <- fluidPage(
  theme = shinytheme("superhero"),
  titlePanel("Drug Use And Abuse"),
  h5(style = "padding-left:1em;",
     "An INFO 201 group project by Bradley Balansay, Sam Chiang, Pranav Kartha, and McKinley Harvey"),
  hr(),
  
  sidebarPanel(
    
    ##################################################
    #  For the summary data, put sidebar stuff here  #
    ##################################################
    conditionalPanel(
      condition = "input.dataTabs == 'Age group vs. Drug Usage'",
      h3("The Data"),
      
      selectInput("drug_choice", "Select a drug to analyze:", 
                  choices = c("alcohol", "marijuana", "cocaine", "crack" , "heroin", "hallucinogen", 
                              "inhalant", "pain.reliever", "oxycontin", "tranquilizer", "stimulant",
                              "meth", "sedative"), 
                  selected = 1),
      
      hr(),
      
      selectInput("min.age", "Minimum Age:", 
                  c("12", "13", "14", "15", "16", 
                    "17", "18", "19", "20", "21", 
                    "22-23", "24-25", "26-29", "30-34", "35-49", "50-64", "65+"), 
                  selected = "12"),
      
      h5(style = "text-align:center;", "to"),
      
      selectInput("max.age", "Maximum Age:", 
                  c("12", "13", "14", "15", "16", 
                    "17", "18", "19", "20", "21", 
                    "22-23", "24-25", "26-29", "30-34", "35-49", "50-64", "65+"), 
                  selected = "65+")
    ),
    
    #####################################################################
    #  Agree on the widgets for plot 1/2 (use and freq), put them here  #
    #####################################################################
    conditionalPanel(
      condition = "input.dataTabs == 'Plot1' | input.dataTabs == 'Plot2'",
      h3('Plot1/2'),
      # create slider input titled Year, with the ticks being the different years
      em("Select a year"),
      selectInput("Age", "Age group:",
                  c("12", "13", "14", "15", "16", 
                    "17", "18", "19", "20", "21", 
                    "22-23", "24-25", "26-29", "30-34", "35-49", "50-64", "65+"))
    ),
    
    ##################################################################
    #  Whatever is used for the Connecticut stuff, put widgets here  #
    ##################################################################
    conditionalPanel(
      condition = "input.dataTabs == 'Case Study'",
      h3('Effects'), 
      sliderInput("year",
                  "Select A Year",
                  min = 2012,
                  max = 2017,
                  value = 2012,
                  sep = ""),
      
      selectInput("fill",
                  "What Would You Like to Compare Within The Charts?",
                  c("Sex",
                    "Location of Death" = "Location")),
      textOutput("intro")
    )
    
  ),
 
  mainPanel(
    tabsetPanel(type = "tabs", id = "dataTabs",
                
                #########################
                #  Tab for the Summary  #
                #########################
                tabPanel("Age group vs. Drug Usage",plotOutput("weedTime"),
                         h3("Summary"),
                         br(), p("This data visualization displays a bar graph showing the distribution of
                                 drug use amoung different age groups. With this data, we wanted to see whether
                                 if there was a specific age where people stoppped using drugs.  The graphs show
                                 that in most cases, drug use is highest during one's late teens/early 20s. In addition, 
                                 this data would allow us to view how socially acceptable certain drugs were for
                                 different age groups. For example, alcohol appear is much more socially acceptable
                                 than other drugs; this is indicated by the amount of older alcohol users being much 
                                 higher than for other drugs.") ,
                                 p("Most of the data follows a bell curve, centered around the age range of 20. This data
                                 also allows us to see data that deviates from this data, and draw conclusions from that.
                                 For example, inhalant use seems to be centered around younger ages. This could be because 
                                 younger people don't have access to other drugs.")),
                
                ##########################
                #  Tab for Plot 1 (Use)  #
                ##########################
                tabPanel("Plot1", 
                         h3("Plot 1"),
                         br(), p("Plot 1"), plotOutput("plot")),
                
                ################################
                #  Tab for Plot 2 (Frequency)  #
                ################################

                tabPanel("Plot2",
                         h3("Drug Use vs. Age Group"),
                         br(), p("Plot 2"), plotOutput("plot2")),
                
                ##############################
                #  Tab for Connecticut Data  #
                ##############################
                tabPanel("Case Study", 
                         h3("Accidental Death By Drug Overdoes in Connecticut"),
                         br(), plotOutput("yearPlot"), h3("How Do Deaths Compare by Sex or Location of Death?"), textOutput("analysis"))
    )
  )
)

shinyUI(ui)