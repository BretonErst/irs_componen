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
suppressMessages(source("source/raw_municipios.R"))


nombres_mun <- da_mun_01$Municipio


## Mapa
# población analfabeta
map_gto_analfabeta <- da_mun_01 %>% 
  select(region = cla_munic,
         value = analfabeta,
         Municipio)


# Mapa
mxmunicipio_choropleth(map_gto_analfabeta,
                       legend = "% Población",
                       zoom = subset(map_gto_analfabeta,
                                     Municipio %in% nombres_mun)$region) +
  theme(text = element_text(family = "Optima"),
        plot.title = element_text(size = 18),
        plot.title.position = "plot",
        plot.caption.position = "plot",
        plot.caption = element_markdown(color = "darkgrey",
                                        hjust = 0),
        legend.position = "right") +
  labs(title = "Porcentaje de Población Analfabeta en Guanajuato",
       subtitle = "Los números y el gradiente de color indican el porcentaje\nde personas mayores de 15 años que no saben leer.",
       caption = "Fuente: Datos del CONEVAL (2020) <br>
       Visualización: Juan L. Bretón, PMP | @BretonPmp") #-> mi_02

ggsave(filename = "mi_02", plot = mi_02, path = "figures/", device = "tiff")










