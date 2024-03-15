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
setwd("/data/Subject/heartscRNAseq/dataset/")
innerpath = "/data/Subject/heartscRNAseq/innerpath/"
datasetID = "GSE165838"
dir_out = paste0("/data/Subject/heartscRNAseq/dataset/",datasetID)

###################### 0.load base function ######################
source(paste0(innerpath,"/","function_use.R"))

###################### 1.Load data ######################
## load expression matrix
dir1 = paste0(dir_out,"/data/raw/")
expr = Read10X(dir1)
## Create a Seurat object
obj = CreateSeuratObject(expr,min.cells = 3,min.features = 200,project = paste0(datasetID))

###################### 2.Quality control ######################
## 2.1 Basic quality control
obj[["percent.mt"]] = PercentageFeatureSet(obj, pattern = "^MT-")
obj@meta.data$nCount_RNA_outlier_2mad = isOutlier(log(obj@meta.data$nCount_RNA),log = F,type = "both",nmads = 2)
obj@meta.data$nFeature_RNA_outlier_2mad = isOutlier(log(obj@meta.data$nFeature_RNA),log = F,type = "both",nmads = 2)
obj@meta.data$percent_mt_outlier_2mad = isOutlier(log1p(obj@meta.data$percent.mt),log = F,type = "higher",nmads = 2)
dataset0 = subset(obj, subset = nCount_RNA_outlier_2mad == "FALSE" &
                    nFeature_RNA_outlier_2mad == "FALSE" & 
                    percent_mt_outlier_2mad == "FALSE")
# saveRDS(dataset0,paste0(dir_out,"/",datasetID,"_QC.Rds"))

## 2.2 Remove doublet cell
dir_doublet = paste0("/data/Subject/heartscRNAseq/dataset/",datasetID,"/doublet")
if(!dir.exists(dir_doublet)){      dir.create(dir_doublet)    }
setwd(dir_doublet)
doublet.rate = data.frame(Rate=c(0.4,0.8,1.6,2.3,3.1,3.9,4.6,5.4,6.1,6.9,7.6),
                        Cell=c(500,1000,2000,3000,4000,5000,6000,7000,8000,9000,10000)
)
doublet.rate$Rate = doublet.rate$Rate / 100
index = max(1,which(doublet.rate$Cell<length(colnames(dataset0))))
dbr0 = doublet.rate[index,1]
set.seed(123)
sce_scDbl = as.SingleCellExperiment(dataset0)
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
write.table(as.data.frame(scDbl.doublet),"dataset_doublet.csv",sep="\t",quote = F,row.names = F,col.names = F)

double_cellss = read.delim("dataset_doublet.csv",stringsAsFactors = F,check.names = F,sep=",",header=F)
head(double_cellss)
cell_use = setdiff(colnames(dataset0),double_cellss$V1)
dataset0 = dataset0[,cell_use]

###################### 3.Standardization,dimensionality reduction and clustering ######################
## 3.1 Standardization
dataset0 = SCTransform(dataset0,verbose = FALSE)
s.genes = cc.genes$s.genes
g2m.genes = cc.genes$g2m.genes
dataset0 = CellCycleScoring(dataset0, s.features = s.genes, g2m.features = g2m.genes, set.ident = TRUE)
dataset0 = SCTransform(dataset0,vars.to.regress = c("percent.mt","S.Score", "G2M.Score"),verbose = FALSE)

### Removing the effects of mitochondrial genes, ribosomal genes, immunoglobulins, and proliferative genes from highly variable genes
blackGene_first = blackGeneWithoutDIG(dataset0,innerpath)
dataset0@assays$SCT@var.features = setdiff(dataset0@assays$SCT@var.features,blackGene_first)
if(length(dataset0@assays$SCT@var.features)<1500){
  print("up nfeatures and run angain")
  dataset0@assays$SCT@var.features = dataset0@assays$SCT@var.features[1:1500]
}else{
  dataset0@assays$SCT@var.features = dataset0@assays$SCT@var.features[1:1500]
}
## 3.2 Dimensionality reduction and clustering
###PCA
dataset0 = RunPCA(dataset0,features=dataset0@assays$SCT@var.features)
dataset0 = FindNeighbors(dataset0, dims = 1:25)
dataset0 = FindClusters(dataset0, resolution = 0.5) 
###UMAP
dataset0 = RunUMAP(dataset0, dims = 1:25)
###T-SNE
dataset0 = RunTSNE(dataset0, dims = 1:25)
###Save
saveRDS(dataset0,paste0(dir_out,"/",datasetID,"_cluster.rds"))
