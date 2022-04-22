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
da_mun_00 <- read_excel("data/IRS_entidades_mpios_2020.xlsx",
                        skip = 5, 
                        sheet = "Municipios",
                        col_names = TRUE)
# Visualización inicial
#glimpse(da_mun_00)

# Cambio de nombre de primeras variables
da_mun_00 %<>% rename("Clave" = ...1,
                      "Entidad" = ...2,
                      "cla_munic" = ...3,
                      "Municipio" = ...4,
                      "pob_total" = ...5)

# Cambio de nombre de variables
da_mun_01 <- da_mun_00 %>% 
  filter(Entidad == "Guanajuato") %>% 
  #filter(row_number() != 1) %>% 
  select(
    Entidad,
    cla_munic,
    Municipio,
    pob_total,
    "analfabeta" = `Población de 15 años o más analfabeta`,
    "no_escuela" = `Población de 6 a 14 años que no asiste a la escuela`,
    "educ_basica_incomp" = `Población de 15 años y más con educación básica incompleta`,
    "sin_salud" = `Población sin derechohabiencia a servicios de salud`,
    "piso_tierra" = `Viviendas con piso de tierra`,
    "sin_sanitario" = `Viviendas que no disponen de excusado o sanitario`,
    "sin_agua" = `Viviendas que no disponen de agua entubada de la red pública`,
    "sin_drenaje" = `Viviendas que no disponen de drenaje`,
    "sin_luz" = `Viviendas que no disponen de energía eléctrica`,
    "sin_lavadora" = `Viviendas que no disponen de lavadora`,
    "sin_refri" = `Viviendas que no disponen de refrigerador`,
    "irs" = ...17,
    "nivel" = ...18) 






















