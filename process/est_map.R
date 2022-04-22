###############################################
##                                           ##
##            JUAN L. BRETON, PMP            ##
##                                           ##
###############################################


## Librerías
library(tidyverse)
library(mxmaps)
library(ggtext)


## Source
suppressMessages(source("source/raw_estados.R"))


## Mapa
# población analfabete
map_analfabeta <- da_est_01 %>% 
  select(region = Clave,
         value = pob_analfabeta)


mxstate_choropleth(map_analfabeta) +
  theme(text = element_text(family = "Optima"),
        plot.title = element_text(size = 18),
        plot.title.position = "plot",
        plot.caption.position = "plot",
        plot.caption = element_markdown(color = "darkgrey",
                                        hjust = 0),
        legend.position = "right") +
  labs(title = "Porcentaje de Población Analfabeta",
       subtitle = "Los números y el gradiente de color indican el porcentaje\nde personas mayores de 15 años que no saben leer.",
       caption = "Fuente: Datos del CONEVAL (2020) <br>
       Visualización: Juan L. Bretón, PMP | @BretonPmp")






