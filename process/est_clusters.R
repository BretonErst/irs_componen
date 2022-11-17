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


## Source
source("source/raw_estados.R")


## Preparación de variables
# Escalado
est_features <- da_est_01 %>% 
  select(4:14) %>% 
  scale()

# Asignacion de nombres a dataframe 
rownames(est_features) <- da_est_01$Entidad


## Clusterización Jerárquica en 5 clusters
# Algoritmo método ward.D2
est_hier_clust <- hclust(dist(est_features), 
                         method = "ward.D2")

# Visualización de dendograma
fviz_dend(x = est_hier_clust,
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
  ylim(-7, NA) +
  labs(title = "Agrupación de Estados por Componentes del IRS",
       y = NULL,
       x = NULL,
       caption = "Fuente: CONEVAL (2020), <br>
       Visualización: @BretonPmp") #-> fi_01

ggsave(filename = "fi_01", plot = fi_01, path = "figures", device = "tiff")

# Podado del árbol 5 clusters
est_hier_clusters <- cutree(tree = est_hier_clust, 
                            k = 5)

# Integración de clustes a la base de datos original
est_clusters <- cbind(da_est_01, est_hier_clusters) 
rownames(est_clusters) <- NULL


## Mapa de calor
pheatmap::pheatmap(mat = est_features,
                   clustering_distance_cols = "euclidean",
                   clustering_distance_rows = "euclidean",
                   clustering_method = "ward.D2",
                   cluster_cols = FALSE,
                   cutree_rows = 5,
                   fontsize = 6,
                   main = "Agrupación de Entidades por Componentes del IRS")


## Visualización de clusters en el espacio
fviz_cluster(object = list(data = est_features,
                           cluster = est_hier_clusters),
             ellipse.type = "norm",
             repel = TRUE,
             show.clust.cent = FALSE) +
  theme(text = element_text(family = "Optima")) +
  labs(title = "Agrupación de Estados por Componentes del IRS")


## Visualización de distancia ente estados
fviz_dist(get_dist(est_features))


## Cálculo del número óptimo de clusters
fviz_nbclust(matrix(est_features),
             kmeans,
             method = "silhouette")


# Ensamble del cálculo del número óptimo de clusters
num_k <- NbClust(data = est_features,
                 distance = "euclidean",
                 min.nc = 2,
                 max.nc = 10,
                 method = "kmeans",
                 index = "alllong")


## Clusterización por K means
klusters <- kmeans(x = est_features, 
                   centers = 5, 
                   nstart = 20)

# Visualización de clusters
fviz_cluster(object = klusters,
             data = est_features,
             repel = TRUE,
             show.clust.cent = FALSE,
             ellipse.type = "euclid")





























