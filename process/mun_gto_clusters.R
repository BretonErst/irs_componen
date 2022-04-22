###############################################
##                                           ##
##            JUAN L. BRETON, PMP            ##
##                                           ##
###############################################


## Librerías
library(ggrepel)
library(ggtext)
library(factoextra)
library(cluster)
library(NbClust)


## Source para Municipios de GUANAJUATO
source("source/raw_municipios.R")


## Preparación de variables
# Escalado de variables
mun_features <- da_mun_01 %>% 
  select(5:15) %>% 
  scale()

# Asignación de nombres de fila
rownames(mun_features) <- da_mun_01$Municipio


## Clustering jerárquico
hier_mun_clust <- hclust(dist(mun_features), 
                         method = "ward.D2")

# Dendograma
fviz_dend(x = hier_mun_clust,
          k = 5,
          repel = TRUE) +
  geom_hline(yintercept = 5, 
             linetype = 2) +
  theme(text = element_text(family = "Optima"),
        plot.title = element_text(size = 18),
        plot.title.position = "plot",
        plot.caption.position = "plot",
        plot.caption = element_markdown(color = "darkgrey",
                                        hjust = 0)) +
  labs(title = "Agrupación de Municipios de Guanajuato por Componentes del IRS",
       y = NULL,
       x = NULL,
       caption = "Fuente: CONEVAL (2020), <br>
       Visualización: @BretonPmp") #-> mi_01


ggsave(filename = "mi_01", plot = mi_01, path = "figures", device = "tiff")



# Asignación de clusters
hier_mun_clusters <- cutree(tree = hier_mun_clust, 
                       k = 5)

municipios_gto_clusters <- cbind(da_mun_01, hier_mun_clusters) 
rownames(municipios_gto_clusters) <- NULL


## Mapa de calor
pheatmap::pheatmap(mat = mun_features,
                   clustering_distance_cols = "euclidean",
                   clustering_distance_rows = "euclidean",
                   clustering_method = "ward.D2",
                   cluster_cols = FALSE,
                   cutree_rows = 5,
                   fontsize = 10,
                   fontsize_col = 6,
                   fontsize_row = 6,
                   main = "Agrupación de Municipios de Guanajuato por\nComponentes del IRS",
                   legend = FALSE)


# Visualización espacial de los municipios de GUANAJUATO
fviz_cluster(object = list(data = mun_features,
                           cluster = hier_mun_clusters),
             ellipse.type = "t",
             repel = TRUE,
             show.clust.cent = FALSE)



## Distancias entre municipios
fviz_dist(get_dist(mun_features))


# Cálculo teórico de número óptimo de clusters
fviz_nbclust(matrix(mun_features),
             kmeans,
             method = "silhouette")

# Ensamble para el calculo de número de clusters
num_k <- NbClust(data = mun_features,
                 distance = "euclidean",
                 min.nc = 2,
                 max.nc = 10,
                 method = "kmeans",
                 index = "alllong")


# Clustering por KMeans
klusters <- kmeans(x = mun_features, 
                   centers = 5, 
                   nstart = 20)

# Visualización
fviz_cluster(object = klusters,
             data = mun_features,
             repel = TRUE,
             show.clust.cent = FALSE,
             ellipse.type = "t")











