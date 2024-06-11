install.packages("magick")

library(gridExtra)
library(magick)

# Create PNG's from plots
png("layouts/Full_map.png")
Full_map
dev.off()

png("layouts/lineplot.png")
lineplot
dev.off()


back_path <- "layouts/Full_map.png"
front_path <- "layouts/lineplot.png"

back <- image_read(back_path)
front <- image_read(front_path)
front <- image_scale(front, "40%")

# Pobranie wymiarów obrazów
width <- image_info(front)$width
height <- image_info(front)$height

# Nałożenie drugiego obrazu na pierwszy w lewym górnym rogu
result <- image_composite(back, front, offset = "+300+40")

image_write(result, "layouts/result.png", quality = 1000)

# Wyświetlenie obrazu wynikowego
plot(result)
