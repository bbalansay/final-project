library("shiny")
library("shinythemes")
library("dplyr")
library("tidyr")
library("ggplot2")

drug.data <- read.csv("data/drug-use.csv", stringsAsFactors = FALSE) 
# fixed the typo in pain.releiver
colnames(drug.data)[18] <- "pain.reliever.frequency"
colnames(drug.data)[17] <- "pain.reliever.use"

drug.long.freq <- gather(drug.data, drugs, values, alcohol.frequency, marijuana.frequency, cocaine.frequency, crack.frequency, 
                         heroin.frequency, hallucinogen.frequency, inhalant.frequency, pain.reliever.frequency, 
                         oxycontin.frequency, tranquilizer.frequency, stimulant.frequency, meth.frequency, sedative.frequency) %>%
  select(age, drugs, values)

drug.long.use <- gather(drug.data, drugs, values, alcohol.use, marijuana.use, cocaine.use, crack.use, 
                        heroin.use, hallucinogen.use, inhalant.use, pain.reliever.use, 
                        oxycontin.use, tranquilizer.use, stimulant.use, meth.use, sedative.use) %>%
  select(age, drugs, values)