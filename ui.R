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
      condition = "input.dataTabs == 'Frequency Plot' | input.dataTabs == 'Usage Plot'",
      h3('Choose the Population'),
      # create slider input titled Year, with the ticks being the different years
      em("Select an age group"),
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
                tabPanel("Frequency Plot", 
                         h3("Drug Use vs. Age Group: Frequency by Age in 2012"),
                         br(), 
                        plotOutput("plot"),
                         br(),
                        p("This plot uses data was derived by the United States Department of Health and Human Services. Here, frequency is measured by the median number of times in an age group that used
                           the specific drug in the past 12 months of 2012. By looking at the average number
                          of usages across different ages, we can answer the question about how much exactly do the young, middle-aged, or elderly use drugs."), 
                        p("It is shocking to find that the youngest age group, which is 12 years old, use hallucinogens and tranquilizers the most. Moreover, it is reported
                          that they used heroin just a little over 30 number of times in the past 12 months. This might've been the most
                          questionable discovery. However, the rest shows more understandable trends. Alcohol usage averages to around 15 when the respondants are 17 years old
                          or younger. As soon as they turn 18, the amounts go up in considerable amounts. By age 20, alcohol usage hits about 50. Another interesting discovery was 
                          that all the drugs besides inhalants and hallucinogens were quite high by the ages of 30-34. In the next category of 35-49, however, all of the drugs 
                          drop in numbers besides heroin, which towers over the others. In the next age group, 50-64, sedatives become the dominant drug, which might make sense as people
                          become older. Lastly, stimulants are the ones to surprisingly dominate all categories in the age group of 65+. All in all, it seems to be that in certain age groups,
                          one to three drugs usually surpasses the others in usage as they get older.")),
                
                ################################
                #  Tab for Plot 2 (Frequency)  #
                ################################

                tabPanel("Usage Plot",
                         h3("Drug Use vs. Age Group: Usage by Age in 2012"),
                         br(), plotOutput("plot2"),
                         br(),
                         p("This next plot also uses data derived from the United States Department of Health and Human Services. This data calculates usage, which
                           is defined by the percentage of those in the specified age group that used a certain drug in the past 12 months of 2012. By looking at percentages
                           instead of an estimated amount previously, it gives us a better overview of drug use. Thus, these graphs can answer the question about
                           what drugs are least used as time goes on, and if these drugs that aren't used as much eventually increase."),
                         p("Each age group had a different amount of respondants. The percentages were based on 2798 12 year olds, 2757 13 year olds, 2792 14 year olds,
                           2956 15 year olds, 3058 16 year olds, 3038 17 year olds, 2469 18 year olds, 2223 19 year olds, 2271 20 year olds, 2354 21 year olds, 
                           4707 22-23 year olds, 4591 24-25 year olds, 2628 26-29 year olds, 2864 30-34 year olds, 7391 35-49, 3923 50-64 year olds, and 2448 65+ year olds."),
                         p("It is no surprise that alcohol and marijuana are the dominant drugs in almost every age group, so we can disregard that for now. For the children younger than 16, inhalants and
                           pain relievers were popular, hovering around 5%. However, as they got older, those drugs start decreasing, and we can see a steady growth of marijuana and alcohol. All other drugs remain low -- 
                           5%. Interestingly, this is consistent all the way until the oldest age group. In fact, almost all of the drugs eventually fall below 2% and even 0% in the 65+ category, where alcohol is still used
                           by over 70% of the respondants. This was particularly surprising because we thought the use of pain relievers would be much higher as people got old and needed to rely on them for various
                           reasons. Although the percentages were low, tranquilizers and pain relievers were the only two drugs that were still used in the older age group besides alcohol and marijuana.")),
                
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