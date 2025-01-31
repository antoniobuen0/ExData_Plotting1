install.packages("dplyr")
library(dplyr)

# Leer y filtrar los datos
datos_completos <- fread("household_power_consumption.txt", 
                         na.strings = "?",
                         sep = ";",
                         header = TRUE)

datos <- datos_completos %>%
  filter(Date == "1/2/2007" | Date == "2/2/2007") %>%
  mutate(
    DateTime = dmy_hms(paste(Date, Time)),
    Date = dmy(Date)
  )

# Liberar memoria
rm(datos_completos)

# Crear el histograma
png("plot1.png", width = 480, height = 480)

hist(datos$Global_active_power, 
     col = "red", 
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frecuencia")

dev.off()