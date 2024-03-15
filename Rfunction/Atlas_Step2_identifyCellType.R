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
dir_out_Rdata = "/data/Subject/heartscRNAseq/CardioAtlasWebFiles/SCtype_Rdata/"

###################### 0.load base function ######################
source(paste0(innerpath,"/","function_use.R"))

###################### 1.Identity cell type ######################

## 1.1 IdentifyCellTypeMarkersRank.py
"""
# python
import numpy as np ,pandas as pd
import os,statsmodels,math
import statsmodels.stats.multitest as multi
from collections import OrderedDict,Counter

def find_index(list_short,list_full):
    
    locs=[]
    for ww in list_short:
        l0=list_full.index(ww)
        locs.append(ww+" : "+str(l0+1))
    
    return ",".join(locs)
  
atlas_01 = "atlas_human_adult_normal"
dir="/data/Subject/heartscRNAseq/innerpath/"
dir1="/data/Subject/heartscRNAseq/atlas/"+atlas_01+"/result/"
gold_marker=pd.read_csv(dir+"human_heart_marker.txt",header=0,sep="\t")
cluster_marker=pd.read_csv(dir1+"human_adult_atlas_marker.txt",header=0,sep="\t")
w=open(dir1+"human_adult_atlas_celltype_identify.txt","w")
for i in range(0,cluster_marker.shape[1]):
    class0=cluster_marker.iloc[:,i].tolist()
    zd=OrderedDict({}) 
    for ind,cols in gold_marker.iterrows():
        ct0=cols[0]
        markers0=cols[2].split(",")
        inter_marker=list(set(class0).intersection(set(markers0)))
        if len(inter_marker)==0:
            zd[ct0]="-"
        else:
            locs0=find_index(inter_marker,class0)
            zd[ct0]=ct0+"("+locs0+")"
    for k,v in zd.items():
        if v !="-":
            w.write("class"+str(i)+"\t"+v+"\n")

w.close()


"""

## 1.2 add cell type based on the result from 1.1
human_adult_atlas_use = readRDS(paste0(dir_out,"human_adult_atlas.rds"))
human_adult_atlas_use@meta.data$cell_type = ifelse(human_adult_atlas_use@meta.data$seurat_clusters %in% c(0,5),"FB",
                                                   ifelse(human_adult_atlas_use@meta.data$seurat_clusters %in% c(),"EC",
                                                          ifelse(human_adult_atlas_use@meta.data$seurat_clusters %in% c(1,4,11,14,26,31),"PAPC",
                                                                 ifelse(human_adult_atlas_use@meta.data$seurat_clusters %in% c(2,6,7,12,13,16,17,18,19,21,23,27,30),"CM", 
                                                                        ifelse(human_adult_atlas_use@meta.data$seurat_clusters %in% c(),"Pericyte", 
                                                                               ifelse(human_adult_atlas_use@meta.data$seurat_clusters %in% c(24,28),"MP",
                                                                                      ifelse(human_adult_atlas_use@meta.data$seurat_clusters %in% c(9),"Mono",
                                                                                             ifelse(human_adult_atlas_use@meta.data$seurat_clusters %in% c(3,25),"SMC",
                                                                                                    ifelse(human_adult_atlas_use@meta.data$seurat_clusters %in% c(8,15),"T",
                                                                                                           ifelse(human_adult_atlas_use@meta.data$seurat_clusters %in% c(20),"Neuron",
                                                                                                                  ifelse(human_adult_atlas_use@meta.data$seurat_clusters %in% c(),"Goblet",
                                                                                                                         ifelse(human_adult_atlas_use@meta.data$seurat_clusters %in% c(32),"Mast",
                                                                                                                                ifelse(human_adult_atlas_use@meta.data$seurat_clusters %in% c(22),"DC",
                                                                                                                                       "Unknown" )))))))))))))
cell_cluster_Celltype = human_adult_atlas_use@meta.data[,c("seurat_clusters","cell_type")]
saveRDS(human_adult_atlas_use,paste0(dir_out,"/",atsID,".rds"))
Idents(human_adult_atlas_use) = human_adult_atlas_use@meta.data$cell_type

## 1.3 find high mutation markers for the cluster
celltype_marker_cosg = cosg(
  human_adult_atlas_use,
  groups="all",
  assay="SCT",
  slot="data",
  mu=100,
  n_genes_user=100
)
celltype_marker = celltype_marker_cosg$names
celltype_marker[1:3,1:3]
cluster_marker_top = t(celltype_marker_cosg$names)
cosg_marker_infor = cosg_marker_wilcox(human_adult_atlas_use,cluster_marker_top)
write.table(cosg_marker_infor,paste0(dir_out,"ALL_celltype_markers.txt"), sep="\t",row.names =F, col.names =T, quote =F)
###del Unknown
if ("Unknown" %in% colnames(celltype_marker)){
  celltype_marker = select(celltype_marker,-"Unknown")
}
library(limma)
len = read.delim(paste0(innerpath,"gene_length1.txt"),sep="\t",header=T,row.names=1)
len = len[!duplicated(len$symbol),]
rownames(len) = len$symbol
gene = intersect(as.vector(as.matrix(celltype_marker)),rownames(len))
other_gene = setdiff(as.vector(as.matrix(celltype_marker)),gene)
alias = lapply(other_gene,function(x){
  alias2Symbol(x,expand.symbols = T)
})

list = list()
for(i in 1:length(alias)){
  if(length(alias[[i]])==0){
    list[[i]] = NA
  }
  if(length(alias[[i]])==1){
    if(!(alias[[i]][1] %in% rownames(len))){
      list[[i]] = NA
    }else{list[[i]] = rownames(len)[which(rownames(len)==alias[[i]][1])]
    }
  }
  if(length(alias[[i]])==2){
    if(!(alias[[i]][1] %in% rownames(len))){
      list[[i]] = NA
    }else{list[[i]] = rownames(len)[which(rownames(len)==alias[[i]][1])]
    }
  }
  if(length(alias[[i]])==3){
    if(!(alias[[i]][1] %in% rownames(len))){
      list[[i]] = NA
    }else{list[[i]] = rownames(len)[which(rownames(len)==alias[[i]][1])]
    }
  }
}

ind = which(!is.na(list))
list = list[ind]
a = other_gene[ind]
list = unlist(list)
gene1 = c(gene,list)
gene2 = c(gene,a)

len1 = len[match(gene1,rownames(len)),]
rownames(len1) = gene2

human_adult_atlas_use_f = human_adult_atlas_use[gene2,]
count = data.frame(GetAssayData(human_adult_atlas_use_f,"counts"))
n = count / (len1$length/1000)
tpm = data.frame(t(t(n)/colSums(n)*1e6))
colnames(tpm) = colnames(human_adult_atlas_use_f)

marker_filter = data.frame(sig_gene=NULL,celltype=NULL)
for (i in 1:length(colnames(celltype_marker))){
  cat(i)
  clu_0 = intersect(as.character(celltype_marker[,i]),gene2)
  df_clu0 = marker_detect_cosg(clu_0,colnames(celltype_marker)[i],human_adult_atlas_use,tpm)
  
  if(class(df_clu0) !="character"){
    marker_filter = rbind(marker_filter,df_clu0)
  }
}
write.table(marker_filter,paste0(dir_out,"ALL_markers_filter.txt"), sep="\t",row.names =F, col.names =T, quote =F)


celltype_markers = read.table(paste0(dir_out,"ALL_markers_filter.txt"),sep = "\t",header = T,stringsAsFactors = F)
###有Unknown删除Unknown
if("Unknown" %in% celltype_markers$celltype){
  celltype_markers = celltype_markers[which(celltype_markers$celltype !="Unknown"),]
}
######sctype base file#######
clusters = unique(celltype_markers$celltype)
gs_positive = list()
gs_negative = list()
for (i in 1:length(clusters)) {
  gs_positive[[i]] = celltype_markers$sig_gene[which(celltype_markers$celltype %in% clusters[i])]
  gs_negative[[i]] = as.character()
}
names(gs_positive) = clusters
names(gs_negative) = clusters
gs_list = list(gs_positive = gs_positive,
              gs_negative = gs_negative)

save(gs_list,file = paste0(dir_out_Rdata,"sctype_",atsID,"_marker.RData"))



