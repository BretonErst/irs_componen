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
suppressMessages(source("source/raw_municipios.R"))



## Carga del archivo shape
gto_map <- 
  st_read("source/conjunto_de_datos/gto/11mun.shp")


# integración con base de datos
base_gto_mapa <- 
  gto_map %>% 
  left_join(da_mun_01, by = c("CVEGEO" = "cla_munic"))



## Visualización de mapa
# con piso de tierra
limite <- 
  round(c(min(base_gto_mapa$piso_tierra),
          max(base_gto_mapa$piso_tierra)),
        digits = 1)


base_gto_mapa %>% 
  ggplot(aes(fill = piso_tierra)) +
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
    labs(title = "Población con piso de tierra",
         subtitle = "Por municipio",
         caption = "Fuente: CONEVAL Índice de Rezago Social 2020<br>
                 Visualización: Juan L. Bretón, PMP | @BretonPmp") +
    scale_fill_gradient(name = "Porcentaje de\npersonas", 
                        low = "#FFFFFF",
                        high = "#0465AA",
                        limits = limite,
                        breaks = round(seq(limite[1], limite[2], length.out = 4),
                                       digits = 1))










