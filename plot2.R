# Cargar los paquetes necesarios
library(dplyr)

# Leer y filtrar los datos
datos_completos2 <- fread("household_power_consumption.txt", 
                         na.strings = "?",
                         sep = ";",
                         header = TRUE)

datos2 <- datos_completos2 %>%
  filter(Date == "1/2/2007" | Date == "2/2/2007") %>%
  mutate(
    DateTime = dmy_hms(paste(Date, Time)),
    Date = dmy(Date)
  )

# Liberar memoria
rm(datos_completos2)

# Crear el gráfico de líneas
png("plot2.png", width = 480, height = 480)

plot(datos2$DateTime, datos2$Global_active_power, 
     type = "l", 
     xlab = "", 
     ylab = "Global Active Power (kilowatts)")

dev.off()
