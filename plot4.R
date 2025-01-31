# plot4.R

# Cargar data.table y dplyr
library(data.table)
library(dplyr)
library(lubridate)

# Leer y filtrar los datos
datos_completos <- fread("household_power_consumption.txt", 
                         na.strings = "?",
                         sep = ";",
                         header = TRUE)

datos4 <- datos_completos %>%
  filter(Date == "1/2/2007" | Date == "2/2/2007") %>%
  mutate(
    DateTime = dmy_hms(paste(Date, Time)),
    Date = dmy(Date)
  )

# Liberar memoria
rm(datos_completos)

# Crear el gráfico combinado
png("plot4.png", width = 480, height = 480)

# Configurar el área de gráficos en 2x2
par(mfrow = c(2, 2))

# Gráfico 1: Global Active Power
plot(datos4$DateTime, datos4$Global_active_power, 
     type = "l", 
     xlab = "", 
     ylab = "Global Active Power")

# Gráfico 2: Voltage
plot(datos4$DateTime, datos4$Voltage, 
     type = "l", 
     xlab = "datetime", 
     ylab = "Voltage")

# Gráfico 3: Energy Sub Metering
plot(datos4$DateTime, datos4$Sub_metering_1, 
     type = "l", 
     col = "black", 
     xlab = "", 
     ylab = "Energy sub metering")
lines(datos4$DateTime, datos4$Sub_metering_2, col = "red")
lines(datos4$DateTime, datos4$Sub_metering_3, col = "blue")
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), 
       lty = 1,
       bty = "n")  # bty="n" elimina el borde de la leyenda

# Gráfico 4: Global Reactive Power
plot(datos4$DateTime, datos4$Global_reactive_power, 
     type = "l", 
     xlab = "datetime", 
     ylab = "Global Reactive Power")

dev.off()
