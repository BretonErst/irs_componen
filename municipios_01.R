###############################################
##                                           ##
##            JUAN L. BRETON, PMP            ##
##                                           ##
###############################################

library(tidyverse)
library(readxl)
library(magrittr)
library(ggrepel)
library(ggtext)
library(factoextra)
library(cluster)
library(NbClust)


da00 <- read_excel("IRS_entidades_mpios_2020.xlsx",
                   skip = 5, 
                   sheet = "Municipios",
                   col_names = TRUE)

glimpse(da00)

da00 %<>% rename("Clave" = ...1,
                 "Entidad" = ...2,
                 "cla_munic" = ...3,
                 "Municipio" = ...4,
                 "pob_total" = ...5)

da01 <- da00 %>% 
  filter(Entidad == "Guanajuato") %>% 
  select(
    cla_munic,
    Municipio,
    pob_total,
    "Analfab" = `Población de 15 años o más analfabeta`,
    "No_escuela" = `Población de 6 a 14 años que no asiste a la escuela`,
    "Educ_bas_incomp" = `Población de 15 años y más con educación básica incompleta`,
    "Sin_salud" = `Población sin derechohabiencia a servicios de salud`,
    "Piso_tierra" = `Viviendas con piso de tierra`,
    "Sin_sanitario" = `Viviendas que no disponen de excusado o sanitario`,
    "Sin_agua" = `Viviendas que no disponen de agua entubada de la red pública`,
    "Sin_drenaje" = `Viviendas que no disponen de drenaje`,
    "Sin_luz" = `Viviendas que no disponen de energía eléctrica`,
    "Sin_lavadora" = `Viviendas que no disponen de lavadora`,
    "Sin_refri" = `Viviendas que no disponen de refrigerador`,
    "irs" = ...17,
    "nivel" = ...18) 

feat <- da01 %>% 
  select(4:14) %>% 
  scale()

rownames(feat) <- da01$Municipio


# Cluster jerárquico
hie_clust <- hclust(dist(feat), 
                    method = "ward.D2")


fviz_dend(x = hie_clust,
          k = 5,
          repel = TRUE) +
  geom_hline(yintercept = 5, 
             linetype = 2)

# Asigna
hie_clusters <- cutree(tree = hie_clust, 
                       k = 5)

df_cluster <- cbind(da01, hie_clusters) 
rownames(df_cluster) <- NULL


pheatmap::pheatmap(mat = feat,
                   clustering_distance_cols = "euclidean",
                   clustering_distance_rows = "euclidean",
                   clustering_method = "ward.D2",
                   cluster_cols = FALSE,
                   cutree_rows = 5,
                   fontsize = 6,
                   main = "Agrupación de Municipios por IRS")


fviz_cluster(object = list(data = feat,
                           cluster = hie_clusters),
             ellipse.type = "t",
             repel = TRUE,
             show.clust.cent = FALSE)




fviz_dist(get_dist(feat))


fviz_nbclust(matrix(feat),
             kmeans,
             method = "silhouette")

num_k <- NbClust(data = feat,
                 distance = "euclidean",
                 min.nc = 2,
                 max.nc = 10,
                 method = "kmeans",
                 index = "alllong")

klusters <- kmeans(x = feat, centers = 5, nstart = 20)

fviz_cluster(object = klusters,
             data = feat,
             repel = TRUE,
             show.clust.cent = FALSE,
             ellipse.type = "t")


