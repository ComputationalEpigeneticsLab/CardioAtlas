# Step2 Identifying cell type

rm(list = ls())
gc()

###################### Load packages ######################
library(patchwork) 
library(Seurat) 
library(dplyr) 
library(ggplot2)
library(tidyverse)
library(data.table)
library(scater)
library(BiocParallel)
library(scDblFinder)
library(COSG)

###################### Work path ######################
setwd("/data/Subject/heartscRNAseq/dataset/")
atsID = "atlas_human_adult_normal"
innerpath = "/data/Subject/heartscRNAseq/innerpath/"
datasetID = "GSE165838"
dir_out = paste0("/data/Subject/heartscRNAseq/dataset/",datasetID)
dir_out_big = paste0("/data/Subject/heartscRNAseq/dataset/",datasetID,"/big_re")
dir_out_small = paste0("/data/Subject/heartscRNAseq/dataset/",datasetID,"/small_re")
dir_sctypeMarkerRdata_big = "/data/Subject/heartscRNAseq/CardioAtlasWebFiles/SCtype_Rdata"
dir_sctypeMarkerRdata_samll = innerpath

###################### 0.load base function ######################
source(paste0(innerpath,"/","function_use.R"))

###################### 1.Load data ######################
dataset0 = readRDS(paste0(dir_out,"/",datasetID,"_cluster.rds"))

###################### 2.identify cell type ######################
source(paste0(innerpath,"/","sctype_score.R"))

## 2.1 Identifying cell types based on atlas
dataset_big = dataset0
load(paste0(dir_sctypeMarkerRdata_big,"/sctype_",atsID,"_marker.RData"))
###run sctype
es.max = sctype_score(scRNAseqData = dataset_big@assays$SCT@scale.data, scaled = TRUE,
                      gs = gs_list$gs_positive, gs2 = gs_list$gs_negative)
cL_resutls = do.call("rbind", lapply(unique(dataset_big@meta.data$seurat_clusters), function(cl){
  es.max.cl = sort(rowSums(es.max[ ,rownames(dataset_big@meta.data[dataset_big@meta.data$seurat_clusters==cl, ])]), decreasing = !0)
  head(data.frame(cluster = cl, type = names(es.max.cl), scores = es.max.cl, ncells = sum(dataset_big@meta.data$seurat_clusters==cl),stringsAsFactors = F), 10)
}))
cluster_celltype = data.frame(cL_resutls %>% group_by(cluster) %>% top_n(n = 1, wt = scores) ,stringsAsFactors = F )
cluster_celltype$type[as.numeric(as.character(cluster_celltype$scores)) < cluster_celltype$ncells/4] = "Unknown"
cell_type_all = c()
for (i in 1:length(dataset_big@meta.data$seurat_clusters)){
  c0=dataset_big@meta.data$seurat_clusters[i]
  c0_celltype=cluster_celltype[which(cluster_celltype$cluster==c0),]$type
  if (length(c0_celltype)>1){
    c0_celltype = paste(c0_celltype,collapse = "_or_")
  }
  cell_type_all = c(cell_type_all,c0_celltype)
}
dataset_big@meta.data$cell_type = cell_type_all
saveRDS(dataset_big,paste0(dir_out,"/",datasetID,"_celltype_big.rds"))
###find markers
Idents(dataset_big) = dataset_big@meta.data$cell_type
celltype_marker_cosg = cosg(
  dataset_big,
  groups = "all",
  assay = "SCT",
  slot = "data",
  mu = 100,
  n_genes_user = 100
)
celltype_marker = celltype_marker_cosg$names
celltype_marker[1:3,1:3]
cluster_marker_top = t(celltype_marker_cosg$names)
cosg_marker_infor = cosg_marker_wilcox(dataset_big,cluster_marker_top)
write.table(cosg_marker_infor,paste0(dir_out,"/ALL_celltype_markers_big.txt"), sep="\t",row.names =F, col.names =T, quote =F)

## 2.2 Identifying cell types based on markers
dataset_small = dataset0
load(paste0(dir_sctypeMarkerRdata_samll,"sctype_marker_small.RData"))
###run sctype 
es.max = sctype_score(scRNAseqData = dataset_small@assays$SCT@scale.data, scaled = TRUE, 
                      gs = gs_list$gs_positive, gs2 = gs_list$gs_negative)
cL_resutls = do.call("rbind", lapply(unique(dataset_small@meta.data$seurat_clusters), function(cl){
  es.max.cl = sort(rowSums(es.max[ ,rownames(dataset_small@meta.data[dataset_small@meta.data$seurat_clusters==cl, ])]), decreasing = !0)
  head(data.frame(cluster = cl, type = names(es.max.cl), scores = es.max.cl, ncells = sum(dataset_small@meta.data$seurat_clusters==cl),stringsAsFactors = F), 10)
}))
###cluster 
cluster_celltype = data.frame(cL_resutls %>% group_by(cluster) %>% top_n(n = 1, wt = scores) ,stringsAsFactors = F )
cluster_celltype$type[as.numeric(as.character(cluster_celltype$scores)) < cluster_celltype$ncells/4] = "Unknown"
cell_type_all = c()
for (i in 1:length(dataset_small@meta.data$seurat_clusters)){
  c0 = dataset_small@meta.data$seurat_clusters[i]
  c0_celltype = cluster_celltype[which(cluster_celltype$cluster==c0),]$type
  if (length(c0_celltype)>1){
    c0_celltype = paste(c0_celltype,collapse = "_or_")
  }
  cell_type_all = c(cell_type_all,c0_celltype)
}
dataset_small@meta.data$cell_type = cell_type_all
saveRDS(dataset_small,paste0(dir_out,"/",datasetID,"_celltype_small.rds"))

###find markers
Idents(dataset_small) = dataset_small@meta.data$cell_type
celltype_marker_cosg = cosg(
  dataset_small,
  groups = "all",
  assay = "SCT",
  slot = "data",
  mu = 100,
  n_genes_user = 100
)
celltype_marker = celltype_marker_cosg$names
celltype_marker[1:3,1:3]
cluster_marker_top = t(celltype_marker_cosg$names)
cosg_marker_infor = cosg_marker_wilcox(dataset_small,cluster_marker_top)
write.table(cosg_marker_infor,paste0(dir_out,"/ALL_celltype_markers_small.txt"), sep="\t",row.names =F, col.names =T, quote =F)
