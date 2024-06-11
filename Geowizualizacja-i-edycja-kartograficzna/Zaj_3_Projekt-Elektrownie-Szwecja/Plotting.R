library(scales)
library(dplyr)
library(sf)

sweden_map <- map("world", "Sweden", fill = TRUE, plot = FALSE)

# Convert map data to a data frame
sweden_df <- fortify(sweden_map)

# Top 3 power plants by GWh
top_power_plants <- power_plant %>% 
  top_n(3, estimated_generation_gwh_2017)



# Plot map of Sweden
Full_map <- ggplot() +
  geom_polygon(data = sweden_df, aes(x = long, y = lat, group = group), fill = "lightgray", color = "white") +
  coord_sf(crs = sf::st_crs(4326)) +
  labs(title = "Power stations in Sweden in 2017", color = "Primary Fuel", size = "Plant capacity by power source (GWh)") +
  theme_void() +
  theme(plot.title = element_text(hjust = 0.5, face = "bold"),legend.box.margin = margin(4, 2, 0, -2, "cm")) +
  
# Plot power station as points
  geom_point(data = power_plant, 
             aes(x = longitude, y = latitude, color = primary_fuel, size = estimated_generation_gwh_2017), 
             alpha = 0.5) +
  scale_size_continuous(breaks = c(200, 1000, 5000, 20000),
                        labels = c("200", "1000", "5000", "20000")) +
# Add labels for top 3 power plants by GWh
  geom_text(data = top_power_plants,
            aes(x = longitude, y = latitude, label = name),
            size = 2, color = "blue", hjust = -0.3, vjust = 0.6, alpha = 0.3)




Full_map

# Plot share of Sweden electricity generation
lineplot <-ggplot() + 
  geom_hline(yintercept = seq(0, 60, by = 10), color = "gray", linetype = "solid", linewidth = 0.7) +
  geom_line(data = electricity_prod_source_stacked, aes(x = Year, y = (coal/sum)*100, color = "coal"), linewidth = 1.5) +
  geom_line(data = electricity_prod_source_stacked, aes(x = Year, y = (gas/sum)*100, color = "gas"), linewidth = 1.5) +
  geom_line(data = electricity_prod_source_stacked, aes(x = Year, y = (oil/sum)*100, color = "oil"), linewidth = 1.5) +
  geom_line(data = electricity_prod_source_stacked, aes(x = Year, y = (nuclear/sum)*100, color = "nuclear"), linewidth = 1.5) +
  geom_line(data = electricity_prod_source_stacked, aes(x = Year, y = (hydro/sum)*100, color = "hydro"), linewidth = 1.5) +
  geom_line(data = electricity_prod_source_stacked, aes(x = Year, y = (wind/sum)*100, color = "wind"), linewidth = 1.5) +
  geom_line(data = electricity_prod_source_stacked, aes(x = Year, y = (bioenergy/sum)*100, color = "bioenergy"), linewidth = 1.5) +
  labs(x = "", y = "", title = "Percentage share of Sweden electricity generation", color = "Color") +
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5, face = "bold")) +
  theme(axis.line.y = element_blank(),
        axis.line.x = element_blank()) +
  scale_x_continuous(expand = c(0, 0)) +
  scale_y_continuous(limits = c(0, 60), labels = function(x) paste0(x, "%"), expand = c(0, 0)) +
  scale_color_manual(values = c("coal" = "khaki", "gas" = "lightgreen", "oil" = "darkorchid1", 
                                "nuclear" = "cadetblue2", "hydro" = "aquamarine1", 
                                "wind" = "hotpink1", "bioenergy" = "lightpink"))


lineplot