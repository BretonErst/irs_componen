###############################################
##                                           ##
##            JUAN L. BRETON, PMP            ##
##                                           ##
###############################################


## Librerías
library(tidyverse)
library(sf)
library(ggtext)


## Source
suppressMessages(source("source/raw_estados.R"))


## Preparación del Mapa
# población educación básica incompleta
mapa_todas <- da_est_01 %>% 
  janitor::clean_names() 
  

# carga del archivo shape
nal_map <- st_read("source/conjunto_de_datos/nal/00ent.shp")


# integración con el archivo de datos
base_mapa_nacional <- nal_map %>% 
  left_join(mapa_todas, 
            by = c("CVEGEO" = "clave"))


## Mapa
# educación básica incompleta
limit <- round(c(min(base_mapa_nacional$educa_basica_incomp),
                 max(base_mapa_nacional$educa_basica_incomp)),
               digits = 1)

base_mapa_nacional %>% 
  ggplot(aes(fill = educa_basica_incomp)) +
    geom_sf(color = "grey60",
            size = 0.7) +
    theme(text = element_text(family = "Encode Sans Condensed"),
          plot.title = element_text(face = "bold", 
                                    size = 16),
          panel.background = element_rect(fill = "#FFFFFF"),
          panel.grid = element_blank(),
          axis.text = element_blank(),
          axis.ticks = element_blank(),
          axis.line = element_blank(),
          plot.caption = element_markdown(color = "darkgrey",
                                          hjust = 0),
          plot.title.position = "plot",
          plot.caption.position = "plot") +
    labs(title = "Población con educación básica incompleta",
         subtitle = "Por entidad federativa",
         caption = "Fuente: CONEVAL Índice de Rezago Social 2020<br>
               Visualización: Juan L. Bretón, PMP | @BretonPmp") +
    scale_fill_gradient(name = "Porcentaje de\npersonas", 
                        low = "#FFFFFF",
                        high = "#D67620",
                        limits = limit,
                        breaks = seq(limit[1], limit[2], length.out = 4))





