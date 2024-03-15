# Step4 Preparing for web

rm(list = ls())
gc()

###################### Load packages ######################
library(patchwork) 
library(Seurat) 
library(dplyr) 
library(ggplot2)
library(tidyverse)
library(data.table)
library(COSG)
library(Matrix)
library(SingleCellExperiment)
library(SummarizedExperiment)
library(reshape)
library(jsonlite)
library(stringr)

###################### Work path ######################
innerpath = "/data/Subject/heartscRNAseq/innerpath/"
datasetID = "GSE165838"
dir_out = paste0("/data/Subject/heartscRNAseq/dataset/",datasetID)
file_web = "/data/Subject/heartscRNAseq/CardioAtlasWebFiles"
dir_web = paste0("/data/Subject/heartscRNAseq/dataset/",datasetID,"/big_re/1_web")
# dir_web = paste0("/data/Subject/heartscRNAseq/dataset/",datasetID,"/small_re/1_web")
if(!dir.exists(dir_web)){      dir.create(dir_web)    }

###################### 0.1 load base function ######################
source(paste0(innerpath,"/","function_use.R"))

###################### 0.2 Load data ######################
dataset_big = readRDS(paste0(dir_out,"/",datasetID,"_celltype_big.rds"))
marker_infor = read.delim(paste0(dir_out,"/ALL_celltype_markers_big.txt"),stringsAsFactors = F)
# dataset_small = readRDS(paste0(dir_out,"/",datasetID,"_celltype_small.rds"))
# marker_infor = read.delim(paste0(dir_out,"/ALL_celltype_markers_small.txt"),stringsAsFactors = F)
color_org = as.matrix(read.table(paste0(innerpath,"/celltypeColor.txt"),header = T,sep = "\t",comment.char = "",row.names = 1))
marker_infor = marker_infor[,c("MarkerGene","Celltype")]
colnames(marker_infor) = c("sig_gene","celltype")
cell_cluster_Celltype = dataset_big@meta.data[,c("seurat_clusters","cell_type")]
cell_cluster_Celltype_use = cell_cluster_Celltype
cell_cluster_Celltype_use$seurat_clusters = paste0("cluster",(cell_cluster_Celltype$seurat_clusters))
cell_cluster_Celltype_use$cellname = rownames(cell_cluster_Celltype_use)
cell_cluster_Celltype_use = cell_cluster_Celltype_use[order(cell_cluster_Celltype_use$cell_type), ]
celltype_u=unique(cell_cluster_Celltype_use$cell_type)
if ("Unknown" %in% celltype_u){
  celltype_u_noUnkown = celltype_u[-which(celltype_u=="Unknown")]
}else{celltype_u_noUnkown=celltype_u}

###################### 1.summary file ######################
Species = "Human"
Technology = "10X"
Disease = "Normal"
Tissue = "Heart"
Annotation = "atlas_human_adult_normal"
Cell_Number = dim(cell_cluster_Celltype_use)[1]
Cell_Type_Number = length(celltype_u)
Marker_Number = length(unique(marker_infor$sig_gene))
Publication = "Sci Adv,33990324"
###···
stopMessage = "no"
out_end = paste0("{","\n",
                 '"Species" :','"',Species,'",',"\n",
                 '"Technology" :','"',Technology,'",',"\n",
                 '"Disease" :','"',Disease,'",',"\n",
                 '"Tissue" :','"',Tissue,'",',"\n",
                 '"Annotation" :','"',Annotation,'",',"\n",
                 '"Cell_Number" :','"',Cell_Number,'",',"\n",
                 '"Cell_Type_Number" :','"',Cell_Type_Number,'",',"\n",
                 '"Marker_Number" :','"',Marker_Number,'",',"\n",
                 '"Publication" :','"',Publication,'",',"\n",
                 '"daset" :','"',datasetID,'",',"\n",
                 '"error_attention" :','"',stopMessage,'"',"\n",
                 '}'
)
write.table(out_end,paste0(dir_web,"/","summary_re.txt"),quote = F,sep = "\t",row.names = F,col.names = F)

###################### 2.tsne/umap file ######################
## 2.1 cluster
color = color_fix(as.character(unique(cell_cluster_Celltype_use$seurat_clusters)),color_org)
readyState = "yes"
out_start = paste0("{","\n",
                    '"readyState" :','"',readyState,'",'
)
write.table(out_start,paste0(dir_web,"/","cluster_re.txt"),quote = F,sep = "\t",row.names = F,col.names = F)
###umap_tsne_function
cluster_num = length(unique(cell_cluster_Celltype_use$seurat_clusters))
cluster_name = paste(sort(unique(cell_cluster_Celltype_use$seurat_clusters)),collapse = ",")
umap_tsne_function_re = umap_tsne_cluster_function(color,"cluster",dir_web,dataset_big,500)
stopMessage = "no"
out_end =  paste0(
  '"cluster_num" :','"',cluster_num,'",',"\n",
  '"cluster_name" :','"',cluster_name,'",',"\n",
  '"error_attention" :','"',stopMessage,'"',"\n",
  '}'
)
write.table(out_end,paste0(dir_web,"/","cluster_re.txt"),quote = F,sep = "\t",row.names = F,col.names = F,append = T)

## 2.2 cell-type
color = color_fix(as.character(unique(cell_cluster_Celltype_use$cell_type)),color_org)
readyState = "yes"
out_start = paste0("{","\n",
                    '"readyState" :','"',readyState,'",'
)
write.table(out_start,paste0(dir_web,"/","celltype_re.txt"),quote = F,sep = "\t",row.names = F,col.names = F)
###umap_tsne_function
cluster_num = length(unique(cell_cluster_Celltype_use$cell_type))
cluster_name = paste(sort(unique(cell_cluster_Celltype_use$cell_type)),collapse = ",")
umap_tsne_function_re = umap_tsne_celltype_function(color,"celltype",dir_web,dataset_big,500)
stopMessage = "no"
out_end = paste0(
  '"cluster_num" :','"',cluster_num,'",',"\n",
  '"cluster_name" :','"',cluster_name,'",',"\n",
  '"error_attention" :','"',stopMessage,'"',"\n",
  '}'
)
write.table(out_end,paste0(dir_web,"/","celltype_re.txt"),quote = F,sep = "\t",row.names = F,col.names = F,append = T)

###################### 3.advance out ######################
readyState = "yes"
out_start = paste0("{","\n",
                    '"readyState" :','"',readyState,'",'
)

write.table(out_start,paste0(dir_web,"/","advance_re.txt"),quote = F,sep = "\t",row.names = F,col.names = F)
## 3.1 barplot  of cell density
cell_infor_table = func_cellTypeTable(cell_cluster_Celltype_use)
polt_data = paste(paste(cell_infor_table$cellNum,cell_infor_table$cellType,sep = ","),collapse = ";")
polt_color = paste(color[cell_infor_table$cellType,],collapse = ",")

## 3.2 table & pie  of cell cycle
dataset_big@meta.data[1:3,]
cell_cycle = dataset_big@meta.data[,c("S.Score","G2M.Score","Phase","cell_type")]
cell_cycle$cellname = rownames(cell_cycle)
colnames(cell_cycle) = c("S_Score","G2M_Score","Phase","cell_type","cellname")
cell_cycle_re = json_table_and_download(cell_cycle,"cellCycel",dir_web)
cell_cycle_webTable = cell_cycle_re$infor_web
cell_cycle_webTableDownload = cell_cycle_re$infor_download
Phase_stas = data.frame(table(cell_cycle$Phase))
pie_label = paste(Phase_stas$Var1,collapse = ",")
pie_value = paste(Phase_stas$Freq,collapse = ",")

## 3.3 table & heatmap  of cell type correlation
cellType_corr_re = cellType_corr(dataset_big,marker_infor$sig_gene)
###table
cellTypeCorr_table = json_table_and_download(cellType_corr_re$cell_cell_AUROC,"cellTypeCorr",dir_web)
cellTypeCorr_webTable = cellTypeCorr_table$infor_web
cellTypeCorr_webTableDownload = cellTypeCorr_table$infor_download
###heatmap
heatmapView_re = heatmapView(cellType_corr_re$celltype_heatmap)
cellTypeCorrHeatmap_x_name = heatmapView_re$x_name
cellTypeCorrHeatmap_y_name = heatmapView_re$y_name
cellTypeCorrHeatmap_z_value = heatmapView_re$z_value
cellTypeCorrHeatmap_max = heatmapView_re$max_v
cellTypeCorrHeatmap_min = heatmapView_re$min_v

## 3.4 table & river  of cell cell communication
df_use = dataset_big@assays$SCT@counts[,cell_cluster_Celltype_use$cellname]
meta = cell_cluster_Celltype_use[,c("cellname","cell_type")]
colnames(meta) = c("cell","cell_type")
color_use = color
celltalker_re = cell_cell_conminication_italktopgenes (df_use,meta,color_use,dir_web,innerpath,"dataset")
italk_circos_file = celltalker_re$Res_circos_file
italk_circos_color = celltalker_re$Res_circos_color
italk_tablefile_web = celltalker_re$Res_tablefile
italk_download_table = celltalker_re$download_table
italk_riverplot_file = celltalker_re$Res_riverplot_file

## 3.5 Functional enrichment
cell_celltype_meanEXP = funtion_infor_celltype_meanExp_mat(dataset_big)
### 3.5.1 enrich GO-bp heatmap&table
GO_BP_re = funtion_phyper_table(marker_infor,celltype_u_noUnkown,innerpath,dir_web,"GO_BP") 
GO_BP_enrich_table_web = GO_BP_re$enrich_table_web
GO_BP_enrich_table_download = GO_BP_re$enrich_table_download
GO_BP_enrich_sig_pair = GO_BP_re$enrich_sig_pair
GO_BP_heatmap_re = funtion_infor_heatmap(cell_celltype_meanEXP,innerpath,dir_web,"GO_BP") ##ssgsea
GO_BP_ssgsea_x_name = GO_BP_heatmap_re$x_name
GO_BP_ssgsea_y_name = GO_BP_heatmap_re$y_name
GO_BP_ssgsea_z_value = GO_BP_heatmap_re$z_value
GO_BP_ssgsea_max = GO_BP_heatmap_re$max_v
GO_BP_ssgsea_min = GO_BP_heatmap_re$min_v
### 3.5.2 enrich KEGG heatmap&table
KEGG_re = funtion_phyper_table(marker_infor,celltype_u_noUnkown,innerpath,dir_web,"KEGG")
KEGG_enrich_table_web = KEGG_re$enrich_table_web
KEGG_enrich_table_download = KEGG_re$enrich_table_download
KEGG_enrich_sig_pair = KEGG_re$enrich_sig_pair
KEGG_heatmap_re = funtion_infor_heatmap(cell_celltype_meanEXP,innerpath,dir_web,"KEGG") ##ssgsea
KEGG_ssgsea_x_name = KEGG_heatmap_re$x_name
KEGG_ssgsea_y_name = KEGG_heatmap_re$y_name
KEGG_ssgsea_z_value = KEGG_heatmap_re$z_value
KEGG_ssgsea_max = KEGG_heatmap_re$max_v
KEGG_ssgsea_min = KEGG_heatmap_re$min_v
### 3.5.3 enrich immue heatmap&table
immue_re = funtion_phyper_table(marker_infor,celltype_u_noUnkown,innerpath,dir_web,"immue")
immue_enrich_table_web = immue_re$enrich_table_web
immue_enrich_table_download = immue_re$enrich_table_download
immue_enrich_sig_pair = immue_re$enrich_sig_pair
immue_heatmap_re = funtion_infor_heatmap(cell_celltype_meanEXP,innerpath,dir_web,"immue") ##ssgsea
immue_ssgsea_x_name = immue_heatmap_re$x_name
immue_ssgsea_y_name = immue_heatmap_re$y_name
immue_ssgsea_z_value = immue_heatmap_re$z_value
immue_ssgsea_max = immue_heatmap_re$max_v
immue_ssgsea_min = immue_heatmap_re$min_v
### 3.5.4 enrich cellstat heatmap&table
cellstat_re = funtion_phyper_table(marker_infor,celltype_u_noUnkown,innerpath,dir_web,"cellstat")
cellstat_enrich_table_web = cellstat_re$enrich_table_web
cellstat_enrich_table_download = cellstat_re$enrich_table_download
cellstat_enrich_sig_pair = cellstat_re$enrich_sig_pair
cellstat_heatmap_re = funtion_infor_heatmap(cell_celltype_meanEXP,innerpath,dir_web,"cellstat") ##ssgsea
cellstat_ssgsea_x_name = cellstat_heatmap_re$x_name
cellstat_ssgsea_y_name = cellstat_heatmap_re$y_name
cellstat_ssgsea_z_value = cellstat_heatmap_re$z_value
cellstat_ssgsea_max = cellstat_heatmap_re$max_v
cellstat_ssgsea_min = cellstat_heatmap_re$min_v

## 3.6 celltype marker violin & feature plot
###marker violin
dir_violin = paste0(file_web,"/webViolin/",datasetID)
if(!dir.exists(dir_violin)){      dir.create(dir_violin)    }
dir_violin = paste0(dir_violin,"/big")
# dir_violin=paste0(dir_violin,"/small")
if(dir.exists(dir_violin)){      unlink(dir_violin, recursive=TRUE)    }
if(!dir.exists(dir_violin)){      dir.create(dir_violin)    }
celltype_markerViolin(dir_violin,dir_web,dataset_big,marker_infor,"advance_re",cell_cluster_Celltype_use)
violin_celltype = paste(celltype_u_noUnkown,collapse = ",")
violin_color = paste(color[celltype_u_noUnkown,1],collapse = ",")
###feature plot
dir_mysql = paste0(file_web,"/mysql/",datasetID)
if(!dir.exists(dir_mysql)){      dir.create(dir_mysql)    }
dir_mysql = paste0(dir_mysql,"/big")
# dir_mysql=paste0(dir_mysql,"/small")
if(dir.exists(dir_mysql)){      unlink(dir_mysql, recursive=TRUE)    }
if(!dir.exists(dir_mysql)){      dir.create(dir_mysql)    }
marker_u = unique(marker_infor$sig_gene)
datasetGeneFeature_UmaptSNE(dataset_big,marker_u,dir_mysql,datasetID)

## 3.7 celltype TF table & circos plot
#tf_infor="no"
tf_infor = "yes"
dir_tf0 = paste0(dir_out,"/big_re/regIdentify")
if(!dir.exists(dir_tf0)){      dir.create(dir_tf0)    }
dir_tf = paste0(dir_out,"/big_re/regIdentify/TF")
if(!dir.exists(dir_tf)){      dir.create(dir_tf)    }
pyscenic_workpath = paste0("/data/Subject/heartscRNAseq/dataset/",datasetID,"/big_re/pyscenic")
file.copy(from = paste0(pyscenic_workpath,"/result_aucell2/regulonAUC_all.csv"), 
          to = paste0(dir_tf,"/regulonAUC_all.csv"))
file.copy(from = paste0(pyscenic_workpath,"/result_aucell2/regulons_all.csv"), 
          to = paste0(dir_tf,"/regulons_all.csv"))
if(tf_infor == "yes"){
  tf_target_infor = read.table(paste0(dir_tf,"/regulons_all.csv"),header = T,sep = ",",comment.char = "")
  tf_auc_infor = read.table(paste0(dir_tf,"/regulonAUC_all.csv"),header = T,sep = ",",comment.char = "",row.names = 1,check.names = F)
  tf_auc_infor[1:3,1:3]
  dir_w = paste0(file_web,"/webReg/TF/",datasetID)
  if(!dir.exists(dir_w)){      dir.create(dir_w)    }
  dir_w = paste0(dir_w,"/big")
  if(!dir.exists(dir_w)){      dir.create(dir_w)    }
  RegTargetTableCircos(dir_w,dir_web,tf_target_infor,tf_auc_infor,"advance_re",cell_cluster_Celltype_use,"tf")
}

## 3.8 write
rbp_infor = "no"
stopMessage = "no"
out_end =  paste0(
  '"cellstat_enrich_table_web" :','"',cellstat_enrich_table_web,'",',"\n",
  '"cellstat_enrich_table_download" :','"',cellstat_enrich_table_download,'",',"\n",
  '"cellstat_enrich_sig_pair" :','"',cellstat_enrich_sig_pair,'",',"\n",
  '"cellstat_ssgsea_x_name" :','"',cellstat_ssgsea_x_name,'",',"\n",
  '"cellstat_ssgsea_y_name" :','"',cellstat_ssgsea_y_name,'",',"\n",
  '"cellstat_ssgsea_max" :','"',cellstat_ssgsea_max,'",',"\n",
  '"cellstat_ssgsea_min" :','"',cellstat_ssgsea_min,'",',"\n",
  '"cellstat_ssgsea_z_value" :','"',cellstat_ssgsea_z_value,'",',"\n",
  '"immue_enrich_table_web" :','"',immue_enrich_table_web,'",',"\n",
  '"immue_enrich_table_download" :','"',immue_enrich_table_download,'",',"\n",
  '"immue_enrich_sig_pair" :','"',immue_enrich_sig_pair,'",',"\n",
  '"immue_ssgsea_x_name" :','"',immue_ssgsea_x_name,'",',"\n",
  '"immue_ssgsea_y_name" :','"',immue_ssgsea_y_name,'",',"\n",
  '"immue_ssgsea_max" :','"',immue_ssgsea_max,'",',"\n",
  '"immue_ssgsea_min" :','"',immue_ssgsea_min,'",',"\n",
  '"immue_ssgsea_z_value" :','"',immue_ssgsea_z_value,'",',"\n",
  '"KEGG_enrich_table_web" :','"',KEGG_enrich_table_web,'",',"\n",
  '"KEGG_enrich_table_download" :','"',KEGG_enrich_table_download,'",',"\n",
  '"KEGG_enrich_sig_pair" :','"',KEGG_enrich_sig_pair,'",',"\n",
  '"KEGG_ssgsea_x_name" :','"',KEGG_ssgsea_x_name,'",',"\n",
  '"KEGG_ssgsea_y_name" :','"',KEGG_ssgsea_y_name,'",',"\n",
  '"KEGG_ssgsea_max" :','"',KEGG_ssgsea_max,'",',"\n",
  '"KEGG_ssgsea_min" :','"',KEGG_ssgsea_min,'",',"\n",
  '"KEGG_ssgsea_z_value" :','"',KEGG_ssgsea_z_value,'",',"\n",
  '"GO_BP_enrich_table_web" :','"',GO_BP_enrich_table_web,'",',"\n",
  '"GO_BP_enrich_table_download" :','"',GO_BP_enrich_table_download,'",',"\n",
  '"GO_BP_enrich_sig_pair" :','"',GO_BP_enrich_sig_pair,'",',"\n",
  '"GO_BP_ssgsea_x_name" :','"',GO_BP_ssgsea_x_name,'",',"\n",
  '"GO_BP_ssgsea_y_name" :','"',GO_BP_ssgsea_y_name,'",',"\n",
  '"GO_BP_ssgsea_max" :','"',GO_BP_ssgsea_max,'",',"\n",
  '"GO_BP_ssgsea_min" :','"',GO_BP_ssgsea_min,'",',"\n",
  '"GO_BP_ssgsea_z_value" :','"',GO_BP_ssgsea_z_value,'",',"\n",
  '"tf_infor" :','"',tf_infor,'",',"\n",
  '"rbp_infor" :','"',rbp_infor,'",',"\n",
  '"bar_polt_data" :','"',polt_data,'",',"\n",
  '"bar_polt_color" :','"',polt_color,'",',"\n",
  '"cell_cycle_webTable" :','"',cell_cycle_webTable,'",',"\n",
  '"cell_cycle_webTableDownload" :','"',cell_cycle_webTableDownload,'",',"\n",
  '"cell_cycle_pie_label" :','"',pie_label,'",',"\n",
  '"cell_cycle_pie_value" :','"',pie_value,'",',"\n",
  '"cellTypeCorr_webTable" :','"',cellTypeCorr_webTable,'",',"\n",
  '"cellTypeCorr_webTableDownload" :','"',cellTypeCorr_webTableDownload,'",',"\n",
  '"cellTypeCorrHeatmap_x_name" :','"',cellTypeCorrHeatmap_x_name,'",',"\n",
  '"cellTypeCorrHeatmap_y_name" :','"',cellTypeCorrHeatmap_y_name,'",',"\n",
  '"cellTypeCorrHeatmap_z_value" :','"',cellTypeCorrHeatmap_z_value,'",',"\n",
  '"cellTypeCorrHeatmap_max" :','"',cellTypeCorrHeatmap_max,'",',"\n",
  '"cellTypeCorrHeatmap_min" :','"',cellTypeCorrHeatmap_min,'",',"\n",
  '"italk_circos_file" :','"',italk_circos_file,'",',"\n",
  '"italk_circos_color" :','"',italk_circos_color,'",',"\n",
  '"italk_tablefile_web" :','"',italk_tablefile_web,'",',"\n",
  '"italk_download_table" :','"',italk_download_table,'",',"\n",
  '"italk_riverplot_file" :','"',italk_riverplot_file,'",',"\n",
  '"violin_celltype" :','"',violin_celltype,'",',"\n",
  '"violin_color" :','"',violin_color,'",',"\n",
  '"error_attention" :','"',stopMessage,'"',"\n",
  '}'
)

write.table(out_end,paste0(dir_web,"/","advance_re.txt"),quote = F,sep = "\t",row.names = F,col.names = F,append = T)

###################### 4.marker wilcox table & heatmap ######################
color_celltype = color_fix(as.character(unique(cell_cluster_Celltype$cell_type)),color_org)
###change Seurat::Idents
dataset_big_celltype = dataset_big
dataset_big_celltype@meta.data$seurat_clusters_org = dataset_big_celltype@meta.data$seurat_clusters
Idents_new = cell_cluster_Celltype$cell_type
names(Idents_new) = rownames(cell_cluster_Celltype)
Seurat::Idents(object = dataset_big_celltype)=Idents_new
dataset_big_celltype$seurat_clusters = Idents_new
## 4.1 marker wilcox table
test = Seurat::Idents(object = dataset_big_celltype)
cell_to_celltype = data.frame(cells = names(test),cellTypes = unname(test))
mat = dataset_big_celltype@assays$SCT@counts
p0 = c()
dfr0 = c()
fc0 = c()
for(i in 1:dim(marker_infor)[1]){
  #i=1
  gene0 = marker_infor[i,1]
  celltype0 = marker_infor[i,2]
  celltype0_cells = cell_to_celltype[which(cell_to_celltype$cellTypes == celltype0),]$cells
  celltype0_other = setdiff(cell_to_celltype$cells,celltype0_cells)
  celltype0_cells_exp = mat[gene0,celltype0_cells]
  celltype0_other_exp = mat[gene0,celltype0_other]
  w_re = wilcox.test(celltype0_cells_exp,celltype0_other_exp,alternative = "greater")
  
  p0 = c(p0,w_re$p.value)
  if (mean(celltype0_other_exp) == 0){
    fc = 100000000
  }else{
    fc = mean(celltype0_cells_exp)/mean(celltype0_other_exp)
  }
  
  fc0 = c(fc0,fc)
}
dfr0 = c(dfr0,p.adjust(p0,method="fdr",length(p0)))
marker_infor_wilcox = marker_infor
marker_infor_wilcox$p = p0
marker_infor_wilcox$fdr = dfr0
marker_infor_wilcox$fc = log2(fc0)
colnames(marker_infor_wilcox) = c("marker","celltype","p_value","fdr_value","log2fc")
marker_infor_wilcox[1:3,]
marker_table_and_download(marker_infor_wilcox,"Celltype",dir_web)

## 4.2 marker heatmap
marker_infor_use = marker_infor_wilcox[which(marker_infor_wilcox$fdr_value<0.05),]
marker_infor_use = marker_infor_use[order(marker_infor_use$log2fc,decreasing = T),]
gene_infor_heatmap(dir_web,"Celltype",dataset_big_celltype,marker_infor_use,color_celltype,10,50)





