###############################################
##                                           ##
##            JUAN L. BRETON, PMP            ##
##                                           ##
###############################################


## Librerías
library(tidyverse)
library(readxl)
library(magrittr)


## Adquisición de datos
da_est_00 <- read_excel("data/IRS_entidades_mpios_2020.xlsx",
                        skip = 5, 
                        sheet = "Estados",
                        col_names = TRUE)

# Revisión inicial
#glimpse(da_est_00)

# Cambio de nombre primeras features
da_est_00 %<>% rename("Clave" = ...1,
                      "Entidad" = ...2,
                      "Pob_total" = ...3)

# Cambio de nombre de variables
da_est_01 <- da_est_00%>% 
  filter(Entidad != "Nacional") %>% 
  select(
    Clave,
    Entidad,
    Pob_total,
    "pob_analfabeta" = `Población de 15 años o más analfabeta`,
    "no_escuela" = `Población de 6 a 14 años que no asiste a la escuela`,
    "educa_basica_incomp" = `Población de 15 años y más con educación básica incompleta`,
    "sin_salud" = `Población sin derechohabiencia a servicios de salud`,
    "piso_tierra" = `Viviendas con piso de tierra`,
    "sin_sanitario" = `Viviendas que no disponen de excusado o sanitario`,
    "sin_agua" = `Viviendas que no disponen de agua entubada de la red pública`,
    "sin_drenaje" = `Viviendas que no disponen de drenaje`,
    "sin_luz" = `Viviendas que no disponen de energía eléctrica`,
    "sin_lavadora" = `Viviendas que no disponen de lavadora`,
    "sin_refri" = `Viviendas que no disponen de refrigerador`,
    "irs" = ...15,
    "nivel" = ...16) %>% 
  filter(Clave <= 32)



















