# install.packages("maps")
# install.packages("ggplot2")

library(maps)
library(ggplot2)


# Loading files, limiting the scope of dates to Sweden
file1 <- "data/electricity-prod-source-stacked.csv"
data1 <- read.csv(file1)
electricity_prod_source_stacked <- data1[data1$Entity == "Sweden" , ]

file2 <- "data/global_power_plant_database_v_1_3/global_power_plant_database.csv"
data2 <- read.csv(file2)
power_plant <- data2[data2$country_long == "Sweden" , ]

# Rename columns names 
colnames(electricity_prod_source_stacked)[colnames(electricity_prod_source_stacked) == "Electricity.from.coal...TWh..adapted.for.visualization.of.chart.electricity.prod.source.stacked."] <- "coal"
colnames(electricity_prod_source_stacked)[colnames(electricity_prod_source_stacked) == "Electricity.from.gas...TWh..adapted.for.visualization.of.chart.electricity.prod.source.stacked."] <- "gas"
colnames(electricity_prod_source_stacked)[colnames(electricity_prod_source_stacked) == "Electricity.from.oil...TWh..adapted.for.visualization.of.chart.electricity.prod.source.stacked."] <- "oil"
colnames(electricity_prod_source_stacked)[colnames(electricity_prod_source_stacked) == "Electricity.from.nuclear...TWh..adapted.for.visualization.of.chart.electricity.prod.source.stacked."] <- "nuclear"
colnames(electricity_prod_source_stacked)[colnames(electricity_prod_source_stacked) == "Electricity.from.hydro...TWh..adapted.for.visualization.of.chart.electricity.prod.source.stacked."] <- "hydro"
colnames(electricity_prod_source_stacked)[colnames(electricity_prod_source_stacked) == "Electricity.from.wind...TWh..adapted.for.visualization.of.chart.electricity.prod.source.stacked."] <- "wind"
colnames(electricity_prod_source_stacked)[colnames(electricity_prod_source_stacked) == "Electricity.from.solar...TWh..adapted.for.visualization.of.chart.electricity.prod.source.stacked."] <- "solar"
colnames(electricity_prod_source_stacked)[colnames(electricity_prod_source_stacked) == "Electricity.from.bioenergy...TWh..adapted.for.visualization.of.chart.electricity.prod.source.stacked."] <- "bioenergy"
colnames(electricity_prod_source_stacked)[colnames(electricity_prod_source_stacked) == "Other.renewables.excluding.bioenergy...TWh..adapted.for.visualization.of.chart.electricity.prod.source.stacked."] <- "other"

# Create sum column for every year
sum <- electricity_prod_source_stacked["coal"] + 
  electricity_prod_source_stacked["gas"] + 
  electricity_prod_source_stacked["oil"] + 
  electricity_prod_source_stacked["nuclear"] + 
  electricity_prod_source_stacked["hydro"] +
  electricity_prod_source_stacked["wind"] +
  electricity_prod_source_stacked["solar"] +
  electricity_prod_source_stacked["bioenergy"] +
  electricity_prod_source_stacked["other"]

colnames(sum)[colnames(sum) == "coal"] <- "sum"

electricity_prod_source_stacked$sum <- sum$sum

# Check data
View(electricity_prod_source_stacked)
View(power_plant)


