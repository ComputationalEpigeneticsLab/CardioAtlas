# Step1 Quality control, dimensionality reduction and clustering

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

###################### Work path ######################
workpath = "/data/Subject/heartscRNAseq/"
altas_path = paste0(workpath,"atlas/")
innerpath=paste0(workpath,"innerpath/")
atsID = "atlas_human_adult_normal"
altas_01 = paste0(altas_path,atsID,"/")
setwd(altas_01)
dir_data = dir(paste0(altas_01,"data/"))
dir_out = paste0(altas_01,"result/")
if(!dir.exists(dir_out)){      dir.create(dir_out)    }

###################### 0.load base function ######################
source(paste0(innerpath,"/","function_use.R"))

###################### 1.Load data ######################
human_adult_atlas_list = list()
dir_data2 = dir("data_QC")
for( i in 1:length(dir_data2)){
  dir_data0 = dir_data2[i]
  atlas_0 = readRDS(paste0(altas_01,"data_QC/",dir_data0))
  human_adult_atlas_list[[i]] = atlas_0
}
human_adult_atlas = Reduce(merge,human_adult_atlas_list)
gene_inter = Reduce(intersect,lapply(human_adult_atlas_list,function(v){return(rownames(v))}))
human_adult_atlas_use = human_adult_atlas[gene_inter,]

###################### 2.Quality control ######################
doublet.rate = data.frame(Rate=c(0.4,0.8,1.6,2.3,3.1,3.9,4.6,5.4,6.1,6.9,7.6),
                        Cell=c(500,1000,2000,3000,4000,5000,6000,7000,8000,9000,10000)
)
doublet.rate$Rate = doublet.rate$Rate / 100
index = max(1,which(doublet.rate$Cell<length(colnames(human_adult_atlas_use))))
dbr0 = doublet.rate[index,1]
set.seed(123)
sce_scDbl = as.SingleCellExperiment(human_adult_atlas_use)
tryCatch({
  sce_scDbl = scDblFinder(sce_scDbl, dbr=dbr0, BPPARAM=MulticoreParam(3))
  sce_scDbl$doublet_logic = ifelse(sce_scDbl$scDblFinder.class == "doublet", TRUE, FALSE)
  table(sce_scDbl$scDblFinder.class)
  sce_scDbl = as.Seurat(sce_scDbl)
  sce_scDbl = subset(sce_scDbl,subset=scDblFinder.class=="doublet")
  scDbl.doublet = colnames(sce_scDbl)
},error = function(e){
  scDbl.doublet = ""
})
write.table(as.data.frame(scDbl.doublet),"human_adult_atlas_use_doublet_scDblFinder.csv",sep="\t",quote = F,row.names = F,col.names = F)

double_cellss = read.delim("human_adult_atlas_use_doublet_scDblFinder.csv",header=F,stringsAsFactors = F,check.names = F,sep=",")
cell_use = setdiff(colnames(human_adult_atlas_use),double_cellss$V1)
human_adult_atlas_use = human_adult_atlas_use[,cell_use]

###################### 3.Standardization,dimensionality reduction and clustering ######################
## 3.1 Standardization
human_adult_atlas_use = SCTransform(human_adult_atlas_use,verbose = FALSE)##相当于仅标准化
s.genes = cc.genes$s.genes
g2m.genes = cc.genes$g2m.genes
human_adult_atlas_use  = CellCycleScoring(human_adult_atlas_use, s.features = s.genes, g2m.features = g2m.genes, set.ident = TRUE)
human_adult_atlas_use@meta.data[1:3,]
human_adult_atlas_use = SCTransform(human_adult_atlas_use,vars.to.regress = c("percent.mt","S.Score", "G2M.Score"),verbose = FALSE)

blackGene_first = blackGeneWithoutDIG(human_adult_atlas_use,innerpath)
human_adult_atlas_use@assays$SCT@var.features = setdiff(human_adult_atlas_use@assays$SCT@var.features,blackGene_first)
if(length(human_adult_atlas_use@assays$SCT@var.features)<1500){
  print("up nfeatures and run angain")
  human_adult_atlas_use@assays$SCT@var.features = human_adult_atlas_use@assays$SCT@var.features[1:1500]
}else{
  human_adult_atlas_use@assays$SCT@var.features = human_adult_atlas_use@assays$SCT@var.features[1:1500]
}

## 3.2 Dimensionality reduction and clustering
human_adult_atlas_use = RunPCA(human_adult_atlas_use,features=human_adult_atlas_use@assays$SCT@var.features)
human_adult_atlas_use = RunHarmony(human_adult_atlas_use,max.iter.harmony = 20,group.by.vars = c("orig.ident"),theta=c(2.5))
human_adult_atlas_use = FindNeighbors(human_adult_atlas_use, reduction = "harmony", dims = 1:30) %>% FindClusters(resolution=0.6)
human_adult_atlas_use = RunUMAP(human_adult_atlas_use, reduction = "harmony", dims = 1:30)
human_adult_atlas_use = RunTSNE(human_adult_atlas_use, reduction = "harmony", dims = 1:30,check_duplicates = FALSE)

## 3.3 Identify the markers of the cluster
marker_cosg = cosg(
  human_adult_atlas_use,
  groups="all",
  assay="SCT",
  slot="data",
  mu=100,
  n_genes_user=100
)
cluster_marker_top = marker_cosg$names
dim(cluster_marker_top)

write.table(cluster_marker_top,paste0(dir_out,"human_adult_atlas_marker.txt"),quote=F,row.names=F,col.names=T,sep="\t")
saveRDS(human_adult_atlas_use,paste0(dir_out,"human_adult_atlas.rds"))
