
#================Task 2 - Clustering:=============
install.packages("rio")
library("rio")
install.packages("ggplot2")
library("ggplot2")
install.packages("gridExtra")
library("gridExtra")

load("bcw_processed.Rda")

data_cluster <- x[,1:9]
km <- kmeans(data_cluster,2)

centers = as.data.frame(km$centers)
data_cluster$cluster = factor(km$cluster)

##2D plots for Clump Thickness vs Uniformity of Cell Size , color represented by classes.
p2 <-ggplot(data=x, aes(x=clump_thickness, y=uniformity_of_cell_size, color=class )) + 
  geom_jitter() + 
  scale_color_manual(values = c('black', 'red'))+
  ggtitle("Clump Thickness VS Uniformity of Cell Size (Class)")

##2D plots for Clump Thickness vs Uniformity of Cell Size , color represented by clustering
p1 <-ggplot(data=data_cluster, aes(x=clump_thickness, y=uniformity_of_cell_size, color=cluster )) + 
  geom_jitter() +
  ggtitle("Clump Thickness VS Uniformity of Cell Size (K-mean 2 Clusters)")



grid.arrange(p1, p2, nrow = 1)
##After comparison, two plots are almost the same. we can conclude clusters
##visually does represent the benign vs malignant classes

#more clustering with different cluster number.
km3 <- kmeans(data_cluster,3)
km4 <- kmeans(data_cluster,4)
km5 <- kmeans(data_cluster,5)

data_cluster$cluster = factor(km3$cluster)
p3 <-ggplot(data=data_cluster, aes(x=clump_thickness, y=uniformity_of_cell_size, color=cluster )) + 
  geom_jitter() 

data_cluster$cluster = factor(km4$cluster)
p4 <-ggplot(data=data_cluster, aes(x=clump_thickness, y=uniformity_of_cell_size, color=cluster )) + 
  geom_jitter() 

data_cluster$cluster = factor(km5$cluster)
p5 <-ggplot(data=data_cluster, aes(x=clump_thickness, y=uniformity_of_cell_size, color=cluster )) + 
  geom_jitter()

#examine the K-mean plots
grid.arrange(p1, p3,p4,p5, nrow = 2)

#more clusters does not mean better result


# hierarchical clustering
hm<-hclust(dist(data_cluster))
plot(hm)

# clustering into two group
clusterCut2 <- cutree(hm, 2)
table(clusterCut2,x$class)
hp1 <- ggplot(data =x, aes(x=clump_thickness, y=uniformity_of_cell_size, color = x$class)) + 
  geom_jitter(col = clusterCut2,size = 1) + 
  scale_color_manual(values = c('black', 'red'))

# clustering into three group
clusterCut3 <- cutree(hm, 3)
table(clusterCut3,x$class)

hp2 <- ggplot(data =x, aes(x=clump_thickness, y=uniformity_of_cell_size, color = x$class)) + 
  geom_jitter(col = clusterCut3,size = 1) + 
  scale_color_manual(values = c('black', 'red','green'))

# clustering into four group
clusterCut4 <- cutree(hm, 4)
table(clusterCut4,x$class)
hp3 <- ggplot(data =x, aes(x=clump_thickness, y=uniformity_of_cell_size, color = x$class)) + 
  geom_jitter(col = clusterCut4,size = 1) + 
  scale_color_manual(values = c('black', 'red','green','blue'))

# clustering into five group
clusterCut5 <- cutree(hm, 5)
table(clusterCut5,x$class)

hp4 <- ggplot(data =x, aes(x=clump_thickness, y=uniformity_of_cell_size, color = x$class)) + 
  geom_jitter(col = clusterCut5,size = 1) + 
  scale_color_manual(values = c('black', 'red',"green",'blue','yellow'))

#examine the hieracical clustering plots

grid.arrange(hp1, hp2,hp3,hp4, nrow = 2)

# we have a new subtype of diseases?
