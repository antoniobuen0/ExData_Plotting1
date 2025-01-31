# plot3.R

# Cargar data.table y dplyr
library(data.table)
library(dplyr)
library(lubridate)

# Leer y filtrar los datos
datos_completos <- fread("household_power_consumption.txt", 
                         na.strings = "?",
                         sep = ";",
                         header = TRUE)

datos3 <- datos_completos %>%
  filter(Date == "1/2/2007" | Date == "2/2/2007") %>%
  mutate(
    DateTime = dmy_hms(paste(Date, Time)),
    Date = dmy(Date)
  )

# Liberar memoria
rm(datos_completos)

# Crear el gráfico
png("plot3.png", width = 480, height = 480)

plot(datos3$DateTime, datos3$Sub_metering_1, 
     type = "l", 
     col = "black", 
     xlab = "", 
     ylab = "Energy sub metering")

lines(datos3$DateTime, datos3$Sub_metering_2, col = "red")
lines(datos3$DateTime, datos3$Sub_metering_3, col = "blue")

legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), 
       lty = 1)

dev.off()
