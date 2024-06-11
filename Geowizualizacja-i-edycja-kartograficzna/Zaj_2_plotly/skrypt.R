install.packages("plotly")
library(plotly)

# 1 PODSTAWOWE WYKRESY ----
# wykres liniowy
plot_ly(x = c(1, 2, 3), y = c(5, 6, 7),
        type = "scatter",
        mode = "lines")

# wykres punktowy 
plot_ly(x = c(1, 2, 3), y = c(5, 6, 7),
        type = "scatter",
        mode = "markers")

# wykres słupkowy 
plot_ly(x = c(1, 2, 3), y = c(5, 6, 7),
        type = "bar",
        mode = "markers")

# wykres babelkowy 
plot_ly(x = c(1, 2, 3), y = c(5, 6, 7),
        type = "scatter",
        mode = "markers",
        size = c(1,5,10),
        marker = list(color=c("red","blue","green")))

# mapa ciepla (heatmap) 
plot_ly(z = volcano, type="heatmap")

# wykres liniowy z wypelnieniem 
plot_ly(x = c(1, 2, 3), y = c(5, 6, 7),
        type = "scatter", mode = "lines", fill = "tozeroy")

# 2 WYKRESY STATYSTYCZNE ----
# histogram
x <- rchisq(100, 5, 0)
plot_ly(x=x, type= "histogram")

# boxplot
plot_ly(y = rnorm(50), type = "box") %>%
  add_trace(y = rnorm(50, 1))

# histogram 2d
plot_ly(x = rnorm( 1000, sd = 10), y = rnorm( 1000, sd = 5),
        type = "histogram2d")

# 3 MAPY ----
# mapa punktowa (bubble)
plot_ly(type = "scattergeo",
        lon = c(-73.5, 151.2),
        lat = c(45.5, -33.8),
        marker = list(color = c("red" , "blue"),
                      size = c(30, 50),
                      mode = "markers"))
# kartodiagram
plot_ly(type = "choropleth",
        locations = c( "AZ", "CA", "VT"),
        locationmode = "USA-states",
        colorscale = "Viridis", z = c( 10, 20, 40)) %>%
  layout(geo = list(scope = "usa"))

plot_ly(type = "scattergeo",
        lon = c(42,39),
        lat = c(12,22),
        text = c("Rome" , "Greece") ,
        mode = "markers")

# 4 WYKRESY 3D ----
# wykres powierzchni 3d
plot_ly(type = "surface", z = ~volcano )

# wykres liniowy 3d
plot_ly(type = "scatter3d",
        x = c(9, 8, 5, 1),
        y = c(1, 2, 4, 8),
        z = c(11, 8, 15, 3),
        mode = "lines")

# wykresy punktowe 3d
plot_ly(type = "scatter3d",
        x = c(9, 8, 5, 1),
        y = c( 1, 2, 4, 8),
        z = c( 11, 8, 15, 3),
        mode = "markers")

# 5 WYGLAD - LAYOUT ----
x = 1:100
y1 =2*x + rnorm (100)
y2 =2*x + rnorm (100)

# Legenda
p <- plot_ly(x =x, y = y1, type ="scatter") %>%
  add_trace(x =x,y = y2) %>%
  layout(legend = list(x = 0.5,y = 1, bgcolor = "#F3F3F3"))
p

# Osie 
axis_template <- list(showgrid = F,
                      zeroline = F,
                      nticks = 20,
                      showline = T,
                      title = "AXIS",
                      mirror = "all")

plot_ly(x = x, y = y1, type = "scatter") %>%
  layout(xaxis = axis_template, yaxis = axis_template)

# 6 ZAPIS ----

#install.packages("htmlwidgets")
htmlwidgets::saveWidget(as_widget(p), "wykres1.html")

# 7 HIERARCHIA WYKRESU

# plot_ly()
#   data data.frame
#     add_trace list()
#     x, y, z, c()
#     color, text, size c()
#     colorscale "string" lub c()
#     marker list()
#       color "string"
#       symbol list ()
#     line list ()
#       color "string"
#       width 123
# 
# layout ()
#   title ‘string’
#   xaxis, yaxis list ( )
#   scenelist ( )
#     xaxis, yaxis, zaxis list ( )
#   geo list ( )
#   legend list ( )
#   annotations list ( ) 
#   
# c() = array
# list() = list
# "string" = string
# 123 = number

# 8 WYKRESY GALERIA
https://plotly.com/r/
  # 9 WYGLAD
  https://plotly.com/r/plotly-fundamentals/
  
  # 10 GGPLOT2 -> PLOTLY
  g <- ggplot(faithful, aes(x = eruptions, y = waiting)) +
  stat_density_2d(aes(fill = ..level..), geom = "polygon") + 
  xlim(1, 6) + ylim(40, 100)
g
ggplotly(g)

# Zad. 1. 
# Sprawdź przykładowe wykresy na stronie https://plotly.com/r/



library(plotly)

data <- read.csv('https://raw.githubusercontent.com/plotly/datasets/master/3d-line1.csv')

data$color <- as.factor(data$color)

fig <- plot_ly(data, x = ~x, y = ~y, z = ~z, type = 'scatter3d', mode = 'lines',
               
               opacity = 1, line = list(width = 6, color = ~color, reverscale = FALSE))

fig




library(plotly)

df <- data.frame(
  x = c(1,2,1), 
  y = c(1,2,1), 
  f = c(1,2,3)
)

fig <- df %>%
  plot_ly(
    x = ~x,
    y = ~y,
    frame = ~f,
    type = 'scatter',
    mode = 'markers',
    showlegend = F
  )

fig