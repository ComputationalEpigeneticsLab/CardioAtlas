cluster_sctype_annotation<-function(TaskID,filePath,innerpath,nFeature_RNA_form,nFeature_RNA_to,nCount_RNAt_form,nCount_RNA_to,percent_mt_form,percent_mt_to,
                                          resolution,share_reference ){
  suppressMessages({
    library(Seurat)
    library(dplyr) 
    library(ggplot2)
    library(COSG)
    library(jsonlite)
    library(stringr)
    library(SingleCellExperiment)
  })
  TaskID<-TaskID
  filePath<-filePath
  innerpath<-innerpath
  nFeature_RNA_form<-as.numeric(nFeature_RNA_form)
  nFeature_RNA_to<-as.numeric(nFeature_RNA_to)
  nCount_RNAt_form<-as.numeric(nCount_RNAt_form)
  nCount_RNA_to<-as.numeric(nCount_RNA_to)
  percent_mt_form<-as.numeric(percent_mt_form)
  percent_mt_to<-as.numeric(percent_mt_to)
  resolution<-as.numeric(resolution)
  share_reference<-share_reference
  
  Task_ID <- as.matrix(read.table(paste0(innerpath,"/Job_ID.txt"),header = F,sep = "\t",check.names = F,fill = T))
  Task_ID_new <- Task_ID
  tryCatch({
    ######0. load base function #####
    source(paste0(innerpath,"/","function_use.R"))
    source(paste0(innerpath,"/","sctype_score.R"))
    ##### read seuratobject #####
    UserSeuratObjectQC<-readRDS(paste0(filePath,"/","UserSeuratObjectQC.rds"))
    #### QC del cells & genes ####
    UserSeuratObject <- subset(UserSeuratObjectQC, subset = nFeature_RNA > nFeature_RNA_form & nFeature_RNA < nFeature_RNA_to & percent.mt > percent_mt_form & percent.mt<percent_mt_to & nCount_RNA>nCount_RNAt_form&nCount_RNA<nCount_RNA_to)
    ###LogNormalize
    UserSeuratObject <- NormalizeData(UserSeuratObject, normalization.method = "LogNormalize", scale.factor = 10000)
    ###鎵�2000涓珮鍙樺熀鍥�
    UserSeuratObject <- FindVariableFeatures(UserSeuratObject, selection.method = "vst", nfeatures = 2000)
    ###### cluster #####
    #Scaling the data
    all.genes <- rownames(UserSeuratObject)
    UserSeuratObject <- ScaleData(UserSeuratObject, features = all.genes)
    UserSeuratObject <- RunPCA(UserSeuratObject, features = VariableFeatures(object = UserSeuratObject))
    ##閫夋嫨涓嶅悓鐨剅esolution鍊煎彲浠ヨ幏寰椾笉鍚岀殑cluster鏁扮洰锛屽�艰秺澶luster鏁扮洰瓒婂锛岄粯璁ゅ�兼槸0.5.
    UserSeuratObject <- FindNeighbors(UserSeuratObject, dims = 1:25)
    UserSeuratObject <- FindClusters(UserSeuratObject, resolution = resolution) 
    #UMAP
    UserSeuratObject <- RunUMAP(UserSeuratObject, dims = 1:25, label = T)
    #T-SNE
    UserSeuratObject <- RunTSNE(UserSeuratObject, dims = 1:25, label = T)
    
    load(paste0(innerpath,"/",share_reference,".RData"))
    #####run sctype 
    es.max = sctype_score(scRNAseqData = UserSeuratObject[["RNA"]]@scale.data, scaled = TRUE, 
                          gs = gs_list$gs_positive, gs2 = gs_list$gs_negative)
    cL_resutls = do.call("rbind", lapply(unique(UserSeuratObject@meta.data$seurat_clusters), function(cl){
      es.max.cl = sort(rowSums(es.max[ ,rownames(UserSeuratObject@meta.data[UserSeuratObject@meta.data$seurat_clusters==cl, ])]), decreasing = !0)
      ##鏋勫缓鏁版嵁妗�
      head(data.frame(cluster = cl, type = names(es.max.cl), scores = es.max.cl, ncells = sum(UserSeuratObject@meta.data$seurat_clusters==cl),stringsAsFactors = F), 10)
    }))
    ####cluster re 
    cluster_celltype = data.frame(cL_resutls %>% group_by(cluster) %>% top_n(n = 1, wt = scores) ,stringsAsFactors = F )
    cluster_celltype$type[as.numeric(as.character(cluster_celltype$scores)) < cluster_celltype$ncells/4] = "Unknown"
    cell_type_all=c()
    for (i in 1:length(UserSeuratObject@meta.data$seurat_clusters)){
      c0=UserSeuratObject@meta.data$seurat_clusters[i]
      c0_celltype=cluster_celltype[which(cluster_celltype$cluster==c0),]$type
      if (length(c0_celltype)>1){
        c0_celltype=paste(c0_celltype,collapse = " or ")
      }
      cell_type_all=c(cell_type_all,c0_celltype)
    }
    UserSeuratObject@meta.data$cell_type=cell_type_all
    #####markers
    Idents(UserSeuratObject)<-UserSeuratObject@meta.data$cell_type
    celltype_marker_cosg <- cosg(
      UserSeuratObject,
      groups='all',
      assay='RNA',
      slot='data',
      mu=100,
      n_genes_user=100
    )
    celltype_marker=celltype_marker_cosg$names
    cluster_marker_top=t(celltype_marker_cosg$names)
    cosg_marker_infor<-cosg_marker_wilcox(UserSeuratObject,cluster_marker_top)
    write.table(cosg_marker_infor,paste0(filePath,'/ALL_celltype_markers.txt'), sep='\t',row.names =F, col.names =T, quote =F)
    #####web use
    color_org <- as.matrix(read.table(paste0(innerpath,"/celltypeColor.txt"),header = T,sep = "\t",comment.char = "",row.names = 1))
    marker_infor=cosg_marker_infor[,c("MarkerGene","Celltype")]
    colnames(marker_infor)=c("sig_gene","celltype")
    cell_cluster_Celltype=UserSeuratObject@meta.data[,c("seurat_clusters","cell_type")]
    cell_cluster_Celltype_use=cell_cluster_Celltype
    cell_cluster_Celltype_use$seurat_clusters=paste0("cluster",(cell_cluster_Celltype$seurat_clusters))
    cell_cluster_Celltype_use$cellname=rownames(cell_cluster_Celltype_use)
    cell_cluster_Celltype_use=cell_cluster_Celltype_use[order(cell_cluster_Celltype_use$cell_type), ]
    celltype_u=unique(cell_cluster_Celltype_use$cell_type)
    if ("Unknown" %in% celltype_u){
      celltype_u_noUnkown=celltype_u[-which(celltype_u=="Unknown")]
    }else{celltype_u_noUnkown=celltype_u}
    #####1.  tsne umap out  ########
    color<-color_fix(as.character(unique(cell_cluster_Celltype_use$seurat_clusters)),color_org)
    readyState<-"yes"
    out_start <- paste0("{","\n",
                        '"readyState" :','"',readyState,'",'
    )
    write.table(out_start,paste0(filePath,"/","cluster_re.txt"),quote = F,sep = "\t",row.names = F,col.names = F)
    ####umap_tsne use method: umap_tsne_function###
    cluster_num=length(unique(cell_cluster_Celltype_use$seurat_clusters))
    cluster_name=paste(sort(unique(cell_cluster_Celltype_use$seurat_clusters)),collapse = ",")
    umap_tsne_function_re<-umap_tsne_cluster_function(color,"cluster",filePath,UserSeuratObject,2000000000)
    
    ###路路路
    stopMessage<-"no"
    out_end<- paste0(
      '"cluster_num" :','"',cluster_num,'",',"\n",
      '"cluster_name" :','"',cluster_name,'",',"\n",
      '"error_attention" :','"',stopMessage,'"',"\n",
      '}'
    )
    write.table(out_end,paste0(filePath,"/","cluster_re.txt"),quote = F,sep = "\t",row.names = F,col.names = F,append = T)
    
    ######### 2.2. celltype tsne/umap file #####
    color<-color_fix(as.character(unique(cell_cluster_Celltype_use$cell_type)),color_org)
    readyState<-"yes"
    out_start <- paste0("{","\n",
                        '"readyState" :','"',readyState,'",'
    )
    write.table(out_start,paste0(filePath,"/","celltype_re.txt"),quote = F,sep = "\t",row.names = F,col.names = F)
    ####umap_tsne use method: umap_tsne_function###
    cluster_num=length(unique(cell_cluster_Celltype_use$cell_type))
    cluster_name=paste(sort(unique(cell_cluster_Celltype_use$cell_type)),collapse = ",")
    umap_tsne_function_re<-umap_tsne_celltype_function(color,"celltype",filePath,UserSeuratObject,2000000000)
    ###路路路
    stopMessage<-"no"
    out_end<- paste0(
      '"cluster_num" :','"',cluster_num,'",',"\n",
      '"cluster_name" :','"',cluster_name,'",',"\n",
      '"error_attention" :','"',stopMessage,'"',"\n",
      '}'
    )
    write.table(out_end,paste0(filePath,"/","celltype_re.txt"),quote = F,sep = "\t",row.names = F,col.names = F,append = T)
    
    
    ######3. advance out#####
    readyState<-"yes"
    out_start <- paste0("{","\n",
                        '"readyState" :','"',readyState,'",'
    )
    
    write.table(out_start,paste0(filePath,"/","advance_re.txt"),quote = F,sep = "\t",row.names = F,col.names = F)
    ####1. barplot  of cell density#####
    cell_infor_table=func_cellTypeTable(cell_cluster_Celltype_use)
    polt_data=paste(paste(cell_infor_table$cellNum,cell_infor_table$cellType,sep = ","),collapse = ";")
    polt_color=paste(color[cell_infor_table$cellType,],collapse = ",")
    
    ####4. table & river  of cell cell communication#####
    df_use=UserSeuratObject@assays$RNA@counts[,cell_cluster_Celltype_use$cellname]
    meta=cell_cluster_Celltype_use[,c("cellname","cell_type")]
    colnames(meta)=c("cell","cell_type")
    color_use=color
    celltalker_re= cell_cell_conminication_italktopgenes_mouse(df_use,meta,color_use,filePath,innerpath,"user")
    italk_circos_file<-celltalker_re$Res_circos_file
    italk_circos_color<-celltalker_re$Res_circos_color
    italk_tablefile_web<-celltalker_re$Res_tablefile
    italk_download_table<-celltalker_re$download_table
    italk_riverplot_file<-celltalker_re$Res_riverplot_file
    ####5. function#####
    cell_celltype_meanEXP<-funtion_infor_celltype_meanExp_mat(UserSeuratObject)
    ####5.1 enrich GO-bp heatmap&table#####
    GO_BP_re=funtion_phyper_table(marker_infor,celltype_u_noUnkown,innerpath,filePath,"GO_BP_Mus")
    GO_BP_enrich_table_web<-GO_BP_re$enrich_table_web
    GO_BP_enrich_table_download<-GO_BP_re$enrich_table_download
    #GO_BP_enrich_sig_pair<-GO_BP_re$enrich_sig_pair
    ### ssgsea...
    GO_BP_heatmap_re<-funtion_infor_heatmap_go_kegg(cell_celltype_meanEXP,innerpath,filePath,'GO_BP_Mus')
    ####
    GO_GSVA<-read.delim(paste0(filePath,"/GO_BP_Mus_pathway.txt"),stringsAsFactors = F,check.names = F)
    GO_p<-read.delim(paste0(filePath,"/GO_BP_Mus_enrich_table_Download.txt"),stringsAsFactors = F,check.names = F)
    GO_p<-GO_p[order(GO_p$FDR_value),]
    GO_p_celltype<-unique(GO_p$Celltype)
    select_GO<-c()
    for(nn in 1:length(GO_p_celltype)){
      #nn=1
      GO_p_s<-GO_p[which(GO_p$Celltype==GO_p_celltype[nn]),]
      select_GO<-c(select_GO,GO_p_s$Pathway[1])
    }
    select_GO<-unique(select_GO)
    GO_GSVA<-as.data.frame(GO_GSVA[select_GO,])
    colnames(GO_GSVA)<-GO_p_celltype
    rownames(GO_GSVA)<-select_GO
    GO_p<-GO_p[GO_p$Pathway%in%select_GO,]
    
    GO_BP_ssgsea_x_name<-paste0(colnames(GO_GSVA),collapse = ",")
    GO_BP_ssgsea_y_name<-paste0(rownames(GO_GSVA),collapse = ",")
    GO_BP_ssgsea_z_value<-paste0(apply(GO_GSVA,1,function(x){paste0(x,collapse = ",")}),collapse = ";")
    GO_p<-GO_p[which(GO_p$FDR_value<0.05),]
    GO_BP_ssgsea_max<-1
    GO_BP_ssgsea_min<-0
    GO_BP_enrich_sig_pair<-paste0(paste0(GO_p$Celltype,",",GO_p$Pathway),collapse = ";")
    ####
    ####5.2 enrich KEGG heatmap&table#####
    KEGG_re=funtion_phyper_table(marker_infor,celltype_u_noUnkown,innerpath,filePath,"KEGG_Mus")
    KEGG_enrich_table_web<-KEGG_re$enrich_table_web
    KEGG_enrich_table_download<-KEGG_re$enrich_table_download
    #KEGG_enrich_sig_pair<-KEGG_re$enrich_sig_pair
    ### ssgsea...
    KEGG_heatmap_re<-funtion_infor_heatmap_go_kegg(cell_celltype_meanEXP,innerpath,filePath,'KEGG_Mus')
    ####
    KEGG_GSVA<-read.delim(paste0(filePath,"/KEGG_Mus_pathway.txt"),stringsAsFactors = F,check.names = F)
    KEGG_p<-read.delim(paste0(filePath,"/KEGG_Mus_enrich_table_Download.txt"),stringsAsFactors = F,check.names = F)
    
    KEGG_p<-KEGG_p[order(KEGG_p$FDR_value),]
    KEGG_p_celltype<-unique(KEGG_p$Celltype)
    select_KEGG<-c()
    for(nn in 1:length(KEGG_p_celltype)){
      KEGG_p_s<-KEGG_p[which(KEGG_p$Celltype==KEGG_p_celltype[nn]),]
      select_KEGG<-c(select_KEGG,KEGG_p_s$Pathway[1])
    }
    select_KEGG<-unique(select_KEGG)
    KEGG_GSVA<-as.data.frame(KEGG_GSVA[select_KEGG,])
    colnames(KEGG_GSVA)<-KEGG_p_celltype
    rownames(KEGG_GSVA)<-select_KEGG
    KEGG_p<-KEGG_p[KEGG_p$Pathway%in%select_KEGG,]
    
    KEGG_ssgsea_x_name<-paste0(colnames(KEGG_GSVA),collapse = ",")
    KEGG_ssgsea_y_name<-paste0(rownames(KEGG_GSVA),collapse = ",")
    KEGG_ssgsea_z_value<-paste0(apply(KEGG_GSVA,1,function(x){paste0(x,collapse = ",")}),collapse = ";")
    KEGG_p<-KEGG_p[which(KEGG_p$FDR_value<0.05),]
    KEGG_ssgsea_max<-1
    KEGG_ssgsea_min<-0
    KEGG_enrich_sig_pair<-paste0(paste0(KEGG_p$Celltype,",",KEGG_p$Pathway),collapse = ";")
    ####
    
    
   
    ####6. celltype marker violin & feature plot#####
    ###marker violin
    celltype_markerViolin(filePath,filePath,UserSeuratObject,marker_infor,"advance_re",cell_cluster_Celltype_use)
    violin_celltype=paste(celltype_u_noUnkown,collapse = ",")
    violin_color=paste(color[celltype_u_noUnkown,1],collapse = ",")
    #####7.heatmap marker
    color_celltype<-color_fix(as.character(unique(cell_cluster_Celltype$cell_type)),color_org)
    
    #####1.marker wilcox table ##########
    test=Seurat::Idents(object = UserSeuratObject)
    cell_to_celltype <- data.frame(cells=names(test),cellTypes=unname(test))
    mat=UserSeuratObject@assays$RNA@counts
    p0<-c()
    dfr0<-c()
    fc0<-c()
    for(i in 1:dim(marker_infor)[1]){
      #i=1
      gene0=marker_infor[i,1]
      celltype0=marker_infor[i,2]
      celltype0_cells=cell_to_celltype[which(cell_to_celltype$cellTypes==celltype0),]$cells
      celltype0_other=setdiff(cell_to_celltype$cells,celltype0_cells)
      celltype0_cells_exp=mat[gene0,celltype0_cells]
      celltype0_other_exp=mat[gene0,celltype0_other]
      w_re=wilcox.test(celltype0_cells_exp,celltype0_other_exp,alternative="greater")
      
      p0<-c(p0,w_re$p.value)
      if (mean(celltype0_other_exp)==0){
        fc=100000000
      }else{
        fc=mean(celltype0_cells_exp)/mean(celltype0_other_exp)
      }
      
      fc0<-c(fc0,fc)
    }
    dfr0<-c(dfr0,p.adjust(p0,method="fdr",length(p0)))
    
    marker_infor_wilcox=marker_infor
    marker_infor_wilcox$p=p0
    marker_infor_wilcox$fdr=dfr0
    marker_infor_wilcox$fc=log2(fc0)
    colnames(marker_infor_wilcox)=c("marker","celltype","p_value","fdr_value","log2fc")
    
    marker_table_and_download(marker_infor_wilcox,'Celltype',filePath)
    ######2. marker heatmap #########
    marker_infor_use<-marker_infor_wilcox[which(marker_infor_wilcox$fdr_value<0.05),]
    marker_infor_use<-marker_infor_use[order(marker_infor_use$log2fc,decreasing = T),]
    gene_infor_heatmap_ww(filePath,"Celltype",UserSeuratObject,marker_infor_use,color_celltype,10,50)
    #
    
    ####
    stopMessage<-"no"
    out_end<- paste0(
      '"nFeature_RNA_form" :','"',nFeature_RNA_form,'",',"\n",
      '"nFeature_RNA_to" :','"',nFeature_RNA_to,'",',"\n",
      '"nCount_RNAt_form" :','"',nCount_RNAt_form,'",',"\n",
      '"nCount_RNA_to" :','"',nCount_RNA_to,'",',"\n",
      '"percent_mt_form" :','"',percent_mt_form,'",',"\n",
      '"percent_mt_to" :','"',percent_mt_to,'",',"\n",
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
      '"bar_polt_data" :','"',polt_data,'",',"\n",
      '"bar_polt_color" :','"',polt_color,'",',"\n",
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
    
    write.table(out_end,paste0(filePath,"/","advance_re.txt"),quote = F,sep = "\t",row.names = F,col.names = F,append = T)
    ###
    
    Task_ID_new[which(Task_ID_new[,1]==TaskID),2] <- "success"
    write.table(Task_ID_new,paste0(innerpath,"/Job_ID.txt"),quote = F,sep = "\t",row.names = F,col.names = F)
    ###
    result_message <- paste0("{",'"error_attention" :','"',stopMessage,'"}')
    return(result_message)
  },error = function(e){
    Task_ID_new[which(Task_ID_new[,1]==TaskID),2] <- "dead"
    write.table(Task_ID_new,paste0(innerpath,"/Job_ID.txt"),quote = F,sep = "\t",row.names = F,col.names = F)
    
    stopMessage<-"something wrong"
    result_message <- paste0("{",'"error_attention" :','"',stopMessage,'"}')
    return(result_message)
  })
  
}

