######method######
funtion_infor_heatmap<-function(meanExp_RNA,innerpath,dir_web=dir_web,pathwayName){
  ###meanExp_RNA :result of method funtion_infor_celltype_meanExp_mat
  ###innerpath:pathway file path
  ###pathwayName:pathway Name
  library(GSVA)
  meanExp_RNA<-meanExp_RNA
  innerpath<-innerpath
  pathwayname<-pathwayName
  
  pathway_infor<-read.table(paste0(innerpath,"/",pathwayname,".txt"),header=T,sep="\t",as.is=T,comment.char = "!",check.names = F)
  pathway_list_by <- by(pathway_infor,pathway_infor$pathway,function(x){return(unlist(strsplit(as.character(x[,2]),",")))})
  pathway_list <- list()
  for (i in 1:length(pathway_list_by)){
    pathway_list[[i]]=pathway_list_by[[i]]
    names(pathway_list)[i]=names(pathway_list_by[i])
  }
  
  GSVA_pathway <- gsva(expr=meanExp_RNA, 
                       gset.idx.list=pathway_list, 
                       method="ssgsea")
  if(pathwayName %in% c('KEGG','GO_BP')){
    enrich_sig=read.table(paste0(dir_web,"/",pathwayName,"_enrich_table_Download.txt"),sep = "\t",header=T)
    enrich_sig_top <- enrich_sig %>% group_by(Celltype) %>% top_n( n = -1,wt = FDR_value)
    if(nrow(enrich_sig_top) != length(unique(enrich_sig_top$Celltype))){
      enrich_sig_top$num <- lapply(enrich_sig_top$intermarker,function(v){
        v=as.character(v)
        v=unlist(strsplit(v,','))
        return(length(v))}) %>% unlist
      enrich_sig_top <- enrich_sig_top %>% group_by(Celltype) %>% top_n( n=1,wt=num)
      enrich_sig_top <- as.data.frame(enrich_sig_top)
    }
    if(nrow(enrich_sig_top) != length(unique(enrich_sig_top$Celltype))){
      enrich_sig_top$id=1:nrow(enrich_sig_top)
      enrich_sig_top <- enrich_sig_top %>% group_by(Celltype) %>% top_n( n = -1,wt=id)
      enrich_sig_top <- as.data.frame(enrich_sig_top)
    }
    enrich_sig_top <- enrich_sig_top[,c('Celltype','Pathway','P_value','FDR_value','intermarker')]
    GSVA_pathway=GSVA_pathway[unique(enrich_sig_top$Pathway),]
  }
  
  x_name=paste(colnames(GSVA_pathway),collapse = ",")
  y_name=paste(rownames(GSVA_pathway),collapse = ",")
  z_value=c()
  for (j in 1: length(rownames(GSVA_pathway))) {
    z0=paste(as.character(GSVA_pathway[rownames(GSVA_pathway)[j],]),collapse = ",")
    z_value=c(z_value,z0)
  }
  z_value=paste(z_value,collapse = ";")
  max_v=ceiling(max(GSVA_pathway))
  min_v=floor(min(GSVA_pathway))
  ##return
  out <- list(x_name=x_name, y_name=y_name,z_value=z_value,max_v=max_v,min_v=min_v)
  return(out)
}

funtion_infor_celltype_meanExp_mat<-function(UserSeuratObject){
  ###UserSeuratObject:UserSeuratObject after idents
  UserSeuratObject<-UserSeuratObject
  test=UserSeuratObject@meta.data
  if ("Unknown" %in% test$cell_type ){
    test=test[which(test$cell_type!="Unknown"),]
  }
  test_df <- data.frame(cells=rownames(test),cellTypes=test$cell_type)
  ind_cells <- by(test_df$cells,test_df$cellTypes,function(x){
    return(which(colnames(UserSeuratObject@assays$SCT@counts)%in%x))
  })
  meanExp_oneGene <- function(x){
    sapply(ind_cells, function(ind){
      return(mean(x[ind]))
    })
  }
  meanExp_RNA <- t(apply(UserSeuratObject@assays$SCT@counts, 1, meanExp_oneGene))
  return(meanExp_RNA)
}

funtion_phyper_table<-function(marker_infor,celltype_u_noUnkown,innerpath,dir_out,pathwayName){
  pathway_infor<-read.table(paste0(innerpath,"/",pathwayName,".txt"),header=T,sep="\t",as.is=TRUE,comment.char = "!",check.names = F)
  bg_num<-19955
  enrich_ct<-c()
  enrich_pathway<-c()
  enrich_pvalue<-c()
  enrich_intermarker=c()
  
  for ( i in 1: length(celltype_u_noUnkown)){
    c0=celltype_u_noUnkown[i]
    c0_marker=marker_infor[which(marker_infor$celltype==c0),]$sig_gene
    for (j in 1: dim(pathway_infor)[1]){
      pathway0=unlist(strsplit(pathway_infor[j,]$gene,","))
      x=length(intersect(pathway0,c0_marker))
      if (x>=3){
        p0=1-phyper(x-1,length(c0_marker),bg_num-length(c0_marker),length(pathway0))
        enrich_ct=c(enrich_ct,c0)
        enrich_pathway=c(enrich_pathway,pathway_infor[j,1])
        enrich_pvalue=c(enrich_pvalue,p0)
        enrich_intermarker=c(enrich_intermarker,paste0(intersect(pathway0,c0_marker),collapse = ","))
      }
    }
  }
  fdr_value=p.adjust(enrich_pvalue,method = "BH")
  if (length(enrich_pvalue)==0){
    enrich_re_df="empty"
  }else{
    enrich_re_df=data.frame(Celltype=enrich_ct,Pathway=enrich_pathway,P_value=enrich_pvalue,FDR_value=fdr_value,intermarker=enrich_intermarker)
  }
  
  if(class(enrich_re_df)!="character"){
    enrich_sig<-enrich_re_df[which(enrich_re_df$FDR_value<0.05),]
    if (dim(enrich_sig)[1] !=0){
      ###table
      enrich_sig_json <- toJSON(enrich_sig, pretty=TRUE)
      cat(str_c('{\"data\": ',enrich_sig_json,'}'), file = paste0(dir_out,"/",pathwayName,"_enrich_table.txt"), fill = FALSE, labels = NULL, append = FALSE)
      enrich_table_web <- paste0(pathwayName,"_enrich_table.txt")
      
      enrich_sig_top <- enrich_sig %>% group_by(Celltype) %>% top_n( n = -1,wt = FDR_value)
      
      if(nrow(enrich_sig_top) != length(unique(enrich_sig_top$Celltype))){
        enrich_sig_top$num <- lapply(enrich_sig_top$intermarker,function(v){
          v=as.character(v)
          v=unlist(strsplit(v,','))
          return(length(v))}) %>% unlist
        enrich_sig_top <- enrich_sig_top %>% group_by(Celltype) %>% top_n( n=1,wt=num)
        enrich_sig_top <- as.data.frame(enrich_sig_top)
      }
      if(nrow(enrich_sig_top) != length(unique(enrich_sig_top$Celltype))){
        enrich_sig_top$id=1:nrow(enrich_sig_top)
        enrich_sig_top <- enrich_sig_top %>% group_by(Celltype) %>% top_n( n = -1,wt=id)
        enrich_sig_top <- as.data.frame(enrich_sig_top)
      }
      enrich_sig_top <- enrich_sig_top[,c('Celltype','Pathway','P_value','FDR_value','intermarker')]
      
      enrich_sig_pair <- paste(paste(enrich_sig_top$Celltype,enrich_sig_top$Pathway,sep = ","),collapse = ";")
      ###download table 
      write.table(enrich_sig,paste0(dir_out,"/",pathwayName,"_enrich_table_Download.txt"),row.names = F,col.names = T,sep = "\t",quote = F)
      enrich_table_download=paste0(pathwayName,"_enrich_table_Download.txt")
    }else{
      enrich_table_web<-"empty"
      enrich_sig_pair<-"empty"
      enrich_table_download<-"empty"
    }
  }else{
    enrich_table_web<-"empty"
    enrich_sig_pair<-"empty"
    enrich_table_download<-"empty"
  }
  ##return
  out <- list(enrich_table_web=enrich_table_web, enrich_sig_pair=enrich_sig_pair,enrich_table_download=enrich_table_download)
  return(out)
}

RegTargetTableCircos<-function(dir_w,dir_web,tf_target_infor,tf_auc_infor,filename,cell_cluster_Celltype_use,type){
  
  celltype_u=sort(unique(tf_target_infor$CellType))
  ###cell type infor 
  for (i in 1: length(celltype_u)){
    c0_tfs=unique(tf_target_infor[which(tf_target_infor$CellType==celltype_u[i]),]$TF)
    out0=paste0('"',celltype_u[i],'_',type,'" :','"',paste(c0_tfs,collapse = ","),'",')
    write.table(out0,paste0(dir_web,"/",filename,".txt"),quote = F,sep = "\t",row.names = F,col.names = F,append = T)
  }
  ### table
  filePath_table<-paste0(dir_w,"/table")
  if(!dir.exists(filePath_table)){      dir.create(filePath_table)    }
  for (i in 1: length(celltype_u)){
    c0_tfs=unique(tf_target_infor[which(tf_target_infor$CellType==celltype_u[i]),]$TF)
    c0_cells=cell_cluster_Celltype_use[which(cell_cluster_Celltype_use$cell_type==celltype_u[i]),]$cellname
    c0_cells=intersect(c0_cells,colnames(tf_auc_infor))
    c0_auc=tf_auc_infor[c0_tfs,c0_cells]
    for (j  in 1 :length(c0_tfs)){
      tf0=c0_tfs[j]
      df0=data.frame(AUCscore=as.numeric(c0_auc[tf0,]),cellnames=c0_cells)
      df0$celltype=celltype_u[i]
      df0$tf=tf0
      df0_json <- toJSON(df0, pretty=TRUE)
      cat(str_c('{\"data\": ',df0_json,'}'), file = paste0(filePath_table,"/",celltype_u[i],"_",tf0,"_table.txt"), fill = FALSE, labels = NULL, append = FALSE)
      
    }
  }
  ### circos
  filePath_circos<-paste0(dir_w,"/circos")
  if(!dir.exists(filePath_circos)){      dir.create(filePath_circos)    }
  
  TF_type<-unique(tf_target_infor$TF)
  for(i in 1:length(celltype_u)){
    for (j in 1:length(TF_type)) {
      relation_data<-tf_target_infor[which(tf_target_infor$CellType==celltype_u[i]&tf_target_infor$TF==TF_type[j]),]
      if(nrow(relation_data)>0){
        actors<-data.frame(name=c(unique(relation_data$TF),unique(relation_data$target)),
                           category=c(rep("TF",length(unique(relation_data$TF))),
                                      rep("target",length(unique(relation_data$target)))),
                           size=c(rep(20,length(unique(relation_data$TF))),
                                  rep(10,length(unique(relation_data$target)))),
                           value=c(rep("TF",length(unique(relation_data$TF))),
                                   rep("Target gene",length(unique(relation_data$target)))))
        
        ####Process network graph data into JSON files
        library(jsonlite)
        actors<-actors[order(actors$name),]
        actors<-actors[order(actors$category),]
        ID<-as.character(0:(dim(actors)[1]-1))
        cell_all_name_order<-actors$name
        symbolSize<-actors$size
        value<-actors$value
        category<-rep(0:(length(unique(actors$category))-1),table(actors$category))
        node=data.frame(id=ID,name=cell_all_name_order,symbolSize=symbolSize,value=value,category=category)
        category_all<-data.frame(name=unique(actors$category))
        source=relation_data$TF
        target=relation_data$target
        for (nn in 1:nrow(node)){
          source[which(source==node[nn,2])]<-node[nn,1]
          target[which(target==node[nn,2])]<-node[nn,1]
        }
        links<-data.frame(source=source,target=target)
        circos_data <- list(nodes = node,links = links,categories = category_all)
        jsoncars_circos <- jsonlite::toJSON(circos_data, pretty=T,auto_unbox=F)
        cat(jsoncars_circos, file = paste0(filePath_circos,"/",celltype_u[i],"_",TF_type[j],".json"), 
            fill = FALSE, labels = NULL, append = FALSE)
      }
      
    }
    
  }
}

datasetGeneFeature_UmaptSNE<-function(UserSeuratObject,marker_u,dir_mysql,dataset){
  #UserSeuratObject=human_adult_atlas_use
  #Idents(UserSeuratObject)<-UserSeuratObject@meta.data$cell_type
  
  cell_num=table(UserSeuratObject@meta.data$cell_type)
  
  sample_name_select_all=c()
  for(j in 1:length(cell_num)){
    
    cell_num0=cell_num[j]
    num=as.numeric(cell_num0)
    cell_name=names(cell_num0)
    sample_name = rownames(UserSeuratObject@meta.data[which(UserSeuratObject@meta.data$cell_type == cell_name),])
    
    if(num > 500){
      sample_index = sample(1:num,500,replace = F)
      sample_name_select = sample_name[sample_index]
    }else{
      sample_name_select=sample_name
    }
    sample_name_select_all = c(sample_name_select_all,sample_name_select)
  }
  
  UserSeuratObject = UserSeuratObject[,sample_name_select_all]
  
  cell_tsne_details<-as.data.frame(UserSeuratObject@reductions$tsne@cell.embeddings)
  cell_tsne_details[,3]<-UserSeuratObject$cell_type
  cell_tsne_details[,4]<-colnames(UserSeuratObject)
  marker_u=marker_u[!grepl("/", marker_u)]
  colnames(cell_tsne_details)=c("tSNE_1","tSNE_2","cluster","cellname")
  ###
  cell_umap_details<-as.data.frame(UserSeuratObject@reductions$umap@cell.embeddings)
  cell_umap_details[,3]<-UserSeuratObject$cell_type
  cell_umap_details[,4]<-colnames(UserSeuratObject)
  colnames(cell_umap_details)=c("UMAP_1","UMAP_2","cluster","cellname")
  ###
  gene_all=c()
  tsne_all=c()
  max_all=c()
  umap_all=c()
  for ( i in  1: length(marker_u)){
    g0=marker_u[i]
    cell_umap_details$exp=UserSeuratObject@assays$SCT@counts[g0,as.character(cell_umap_details$cellname)]
    cell_tsne_details$exp=UserSeuratObject@assays$SCT@counts[g0,as.character(cell_tsne_details$cellname)]
    
    tsne=paste(apply(cell_tsne_details[,c("tSNE_1","tSNE_2","cluster","exp")], 1, function(x){paste0("[",x[1],",",x[2],",'",x[3],"',",x[4],"]")}),collapse = ",")
    umap=paste(apply(cell_umap_details[,c("UMAP_1","UMAP_2","cluster","exp")], 1, function(x){paste0("[",x[1],",",x[2],",'",x[3],"',",x[4],"]")}),collapse = ",")
    gene_all=c(gene_all,g0)
    umap_all=c(umap_all,umap)
    tsne_all=c(tsne_all,tsne)
    max_all=c(max_all,ceiling(max(cell_tsne_details$exp)))
  }
  df=data.frame(gene=gene_all,tsne=tsne_all,umap=umap_all,max=max_all,stringsAsFactors = F)
  write.table(df,paste0(dir_mysql,"/",dataset,"_geneFeature_tsne_umap_all.txt"),quote=F,row.names=F,col.names=T,sep="\t")
}

celltype_markerViolin<-function(dir_violin,dir_web,seuratObj,marker_infor,filename,cell_cluster_Celltype_use){
  celltype_u=sort(unique(marker_infor$celltype))
  out0=paste0('"celltype_unique" :','"',paste(celltype_u,collapse = ","),'",')
  write.table(out0,paste0(dir_web,"/",filename,".txt"),quote = F,sep = "\t",row.names = F,col.names = F,append = T)
  marker_u=unique(marker_infor$sig_gene)
  marker_u=marker_u[!grepl("/", marker_u)]
  ###add file
  for(i in 1:length(celltype_u)){
    marker0=unique(marker_infor[which(marker_infor$celltype==celltype_u[i]),]$sig_gene)
    out0=paste0('"',celltype_u[i],'_marker" :','"',paste(marker0,collapse = ","),'",')
    write.table(out0,paste0(dir_web,"/",filename,".txt"),quote = F,sep = "\t",row.names = F,col.names = F,append = T)
  }
  ####violin file
  filePath_violin<-paste0(dir_violin,"/violin")
  if(!dir.exists(filePath_violin)){      dir.create(filePath_violin)    }
  for(i in 1: length(marker_u)){
    cell_use=cell_cluster_Celltype_use$cellname
    cell_type_use=cell_cluster_Celltype_use$cell_type
    if("Unknown" %in% cell_cluster_Celltype_use$cell_type){
      cell_use=cell_cluster_Celltype_use[which(cell_cluster_Celltype_use$cell_type !="Unknown"),]$cellname
      cell_type_use=cell_cluster_Celltype_use[which(cell_cluster_Celltype_use$cell_type !="Unknown"),]$cell_type
    }
    
    
    violin_data0=data.frame(violin_y=seuratObj@assays$SCT@counts[marker_u[i],cell_use],violin_x=cell_type_use)
    write.table(violin_data0,paste0(filePath_violin,"/",marker_u[i],"_violin.csv"),quote=F,row.names=F,col.names=T,sep=",")
    
  }
  
}

color_fix <- function(cellTypes,color){
  #cellTypes : a character vecter for cell types
  #color : a character vecter for colors with rowname
  interCelltype_color <- intersect(rownames(color),cellTypes)
  colors_use <- as.character(color[interCelltype_color,])
  names(colors_use) <- interCelltype_color
  if(length(setdiff(cellTypes,rownames(color)))>0){
    colors_new <- setdiff(colorRampPalette(c("grey","black"))(50),colors_use)[1:length(setdiff(cellTypes,rownames(color)))]
    colors_use <- c(colors_use,colors_new)
    names(colors_use) <- c(interCelltype_color,setdiff(cellTypes,rownames(color)))
  }
  colors_use <- colors_use[cellTypes]
  return(as.matrix(colors_use))
}

umap_tsne_celltype_function<-function(color,method,filePath,seuratobject,cellnum){
  ###color:color for celltype
  ###method method name
  ###filePath: user filePath
  ###seuratobject: userseuratobject,after change Idents
  ###cellnum :cellnum for show in web
  color<-color
  UserSeuratObject<-seuratobject
  method<-method
  filePath<-filePath
  cellnum<-cellnum
  
  cell_umap_details<-as.data.frame(UserSeuratObject@reductions$umap@cell.embeddings)
  cell_umap_details[,3]<-UserSeuratObject$cell_type
  cell_umap_details[,4]<-colnames(UserSeuratObject)
  colnames(cell_umap_details)=c("UMAP_1","UMAP_2","cluster","cellname")
  umap=by(cell_umap_details,cell_umap_details$cluster,func_sample_umap,cellnum,color,filePath,method)
  
  cell_tsne_details<-as.data.frame(UserSeuratObject@reductions$tsne@cell.embeddings)
  cell_tsne_details[,3]<-UserSeuratObject$cell_type
  cell_tsne_details[,4]<-colnames(UserSeuratObject)
  colnames(cell_tsne_details)=c("tSNE_1","tSNE_2","cluster","cellname")
  tsne=by(cell_tsne_details,cell_tsne_details$cluster,func_sample_tsne,cellnum,color,filePath,method)
  
  out <- list(cell_umap_details=cell_umap_details, cell_tsne_details=cell_tsne_details)
  return(out)
}

umap_tsne_cluster_function<-function(color,method,filePath,seuratobject,cellnum){
  ###color:color for celltype
  ###method method name
  ###filePath: user filePath
  ###seuratobject: userseuratobject,after change Idents
  ###cellnum :cellnum for show in web
  color<-color
  UserSeuratObject<-seuratobject
  method<-method
  filePath<-filePath
  cellnum<-cellnum
  
  cell_umap_details<-as.data.frame(UserSeuratObject@reductions$umap@cell.embeddings)
  cell_umap_details[,3]<-UserSeuratObject$seurat_clusters
  cell_umap_details[,4]<-colnames(UserSeuratObject)
  colnames(cell_umap_details)=c("UMAP_1","UMAP_2","cluster","cellname")
  cell_umap_details$cluster=paste0("cluster",(cell_umap_details$cluster))
  umap=by(cell_umap_details,cell_umap_details$cluster,func_sample_umap,cellnum,color,filePath,method)
  
  cell_tsne_details<-as.data.frame(UserSeuratObject@reductions$tsne@cell.embeddings)
  cell_tsne_details[,3]<-UserSeuratObject$seurat_clusters
  cell_tsne_details[,4]<-colnames(UserSeuratObject)
  colnames(cell_tsne_details)=c("tSNE_1","tSNE_2","cluster","cellname")
  cell_tsne_details$cluster=paste0("cluster",(cell_tsne_details$cluster))
  tsne=by(cell_tsne_details,cell_tsne_details$cluster,func_sample_tsne,cellnum,color,filePath,method)
  
  out <- list(cell_umap_details=cell_umap_details, cell_tsne_details=cell_tsne_details)
  return(out)
}

####cell infor1 umap write 
func_sample_umap <- function(df,x,color_all,outpath,method){
  if(nrow(df)<x){rd <- 1:nrow(df)}else{rd <- sample(1:nrow(df),x)}
  df_use <- df[rd,]
  cat("\"",as.character(df_use[1,"cluster"]),"_x_umap\":\"",paste(sprintf("%0.3f", df_use[,"UMAP_1"]),collapse = ","),"\",","\n",sep = "",file = paste0(outpath,"/",method,"_re.txt"),append = T)
  cat("\"",as.character(df_use[1,"cluster"]),"_y_umap\":\"",paste(sprintf("%0.3f", df_use[,"UMAP_2"]),collapse = ","),"\",","\n",sep = "",file = paste0(outpath,"/",method,"_re.txt"),append = T)
  cat("\"",as.character(df_use[1,"cluster"]),"_color_umap\":\"",color_all[as.character(df_use[1,"cluster"]),1],"\",","\n",sep = "",file = paste0(outpath,"/",method,"_re.txt"),append = T)
}

####cell infor1 tsne write 
func_sample_tsne <- function(df,x,color_all,outpath,method){
  if(nrow(df)<x){rd <- 1:nrow(df)}else{rd <- sample(1:nrow(df),x)}
  df_use <- df[rd,]
  cat("\"",as.character(df_use[1,"cluster"]),"_x_tsne\":\"",paste(sprintf("%0.3f", df_use[,"tSNE_1"]),collapse = ","),"\",","\n",sep = "",file = paste0(outpath,"/",method,"_re.txt"),append = T)
  cat("\"",as.character(df_use[1,"cluster"]),"_y_tsne\":\"",paste(sprintf("%0.3f", df_use[,"tSNE_2"]),collapse = ","),"\",","\n",sep = "",file = paste0(outpath,"/",method,"_re.txt"),append = T)
  cat("\"",as.character(df_use[1,"cluster"]),"_color_tsne\":\"",color_all[as.character(df_use[1,"cluster"]),1],"\",","\n",sep = "",file = paste0(outpath,"/",method,"_re.txt"),append = T)
}

###celltype table
func_cellTypeTable <- function(res){
  res <- as.matrix(res)
  cellType_uniq <- unique(res[,"cell_type"])
  res_table <- c()
  for (i in 1:length(cellType_uniq)) {
    cellType_i <- cellType_uniq[i]
    cells_i <- res[which(res[,"cell_type"]==cellType_i),"cellname"]
    cells_i_num <- length(cells_i)
    cells_i_paste <- paste(cells_i,collapse = ",")
    res_table_i <- c(cellType_i,cells_i_num,cells_i_paste)
    res_table <- rbind(res_table,res_table_i)
  }
  return(data.frame(cellType=res_table[,1],
                    cellNum=as.character(res_table[,2]),
                    cells=res_table[,3]))
}

##### json table and download table 
json_table_and_download<-function(table,tablename,filePath){
  ###table: df 
  ###method method name
  ###filePath: user filePath
  library(jsonlite)
  library(stringr)
  celltypeMarker<-table
  method<-tablename
  filePath<-filePath
  
  celltypeMarker_json <- toJSON(celltypeMarker, pretty=TRUE)
  cat(str_c('{\"data\": ',celltypeMarker_json,'}'), file = paste0(filePath,"/",method,"_table.txt"), fill = FALSE, labels = NULL, append = FALSE)
  gene_infor_web=paste0(method,"_table.txt")
  ###download table 
  write.table(celltypeMarker,paste0(filePath,"/",method,"_table_Download.txt"),row.names = F,col.names = T,sep = "\t",quote = F)
  gene_infor_download=paste0(method,"_table_Download.txt")
  ##return
  out <- list(infor_web=gene_infor_web, infor_download=gene_infor_download)
  return(out)
}

####cell type corr
cellType_corr<-function(Seurat_data,markers){
  library(SingleCellExperiment)
  library(SummarizedExperiment)
  library(reshape)
  library(Seurat)
  library(MetaNeighbor)
  Seurat_data<-Seurat_data
  markers<-markers
  
  meta_data<-Seurat_data@meta.data
  exp_data<-as.data.frame(Seurat_data@assays$SCT@counts)
  exp_data<-exp_data[,rownames(meta_data)]
  
  ###Extract information from seurat object
  new_colData = data.frame(
    study_id = rep(1,length(meta_data$cell_type)),
    cell_type = meta_data$cell_type
  )
  pancreas <- SingleCellExperiment(
    Matrix(as.matrix(exp_data), sparse = TRUE),
    colData = new_colData
  )
  
  celltype_NV = MetaNeighborUS(var_genes = unique(markers),
                               dat = pancreas,
                               study_id = pancreas$study_id,
                               cell_type = pancreas$cell_type,
                               fast_version = TRUE)
  
  rownames(celltype_NV)<-unlist(lapply(strsplit(rownames(celltype_NV),"\\|"),function(x){return(x[2])}))
  colnames(celltype_NV)<-unlist(lapply(strsplit(colnames(celltype_NV),"\\|"),function(x){return(x[2])}))
  if("Unknown" %in% colnames(celltype_NV)){
    celltype_NV=celltype_NV[-which(rownames(celltype_NV)=="Unknown"),-which(colnames(celltype_NV)=="Unknown")]
  }
  cell_cell_AUROC<-reshape::melt(as.matrix(celltype_NV))
  colnames(cell_cell_AUROC)<-c("cellType1","cellType2","AUROC")
  
  out<-list(cell_cell_AUROC=cell_cell_AUROC, celltype_heatmap=celltype_NV)
  return(out)
  
}

heatmapView <-function(mat){
  ###mat:col:x, row:y
  x_name=paste(colnames(mat),collapse = ",")
  y_name=paste(rownames(mat),collapse = ",")
  z_value=c()
  for (j in 1: length(rownames(mat))) {
    z0=paste(as.character(mat[rownames(mat)[j],]),collapse = ",")
    z_value=c(z_value,z0)
  }
  z_value=paste(z_value,collapse = ";")
  max_v=ceiling(max(mat))
  min_v=floor(min(mat))
  ##return
  out <- list(x_name=x_name, y_name=y_name,z_value=z_value,max_v=max_v,min_v=min_v)
  return(out)
}

###cellcellcomm
cell_cell_conminication_italktopgenes<- function(data,meta,color,filePath,innerpath,methodname){
  
  
  library(tidyverse)
  library(iTALK)
  
  ##change from FindLR of iTALK
  my_FindLR<-function(data_1,data_2=NULL,datatype,comm_type,database){
    database<-database[database$classification==comm_type,]
    if(datatype=='mean count'){
      gene_list_1<-data_1
      if(is.null(data_2)){
        gene_list_2<-gene_list_1
      }else{
        gene_list_2<-data_2
      }
      ligand_ind<-which(database$ligand %in% gene_list_1$gene)
      receptor_ind<-which(database$receptor %in% gene_list_2$gene)
      ind<-intersect(ligand_ind,receptor_ind)
      FilterTable_1<-database[ind,c('ligand','receptor')] %>%
        left_join(gene_list_1[,c('gene','exprs','cell_type')],by=c('ligand'='gene')) %>%
        dplyr::rename(cell_from_mean_exprs=exprs,cell_from=cell_type) %>%
        left_join(gene_list_2[,c('gene','exprs','cell_type')],by=c('receptor'='gene')) %>%
        dplyr::rename(cell_to_mean_exprs=exprs,cell_to=cell_type)
      ligand_ind<-which(database$ligand %in% gene_list_2$gene)
      receptor_ind<-which(database$receptor %in% gene_list_1$gene)
      ind<-intersect(ligand_ind,receptor_ind)
      FilterTable_2<-database[ind,c('ligand','receptor')] %>%
        left_join(gene_list_2[,c('gene','exprs','cell_type')],by=c('ligand'='gene')) %>%
        dplyr::rename(cell_from_mean_exprs=exprs,cell_from=cell_type) %>%
        left_join(gene_list_1[,c('gene','exprs','cell_type')],by=c('receptor'='gene')) %>%
        dplyr::rename(cell_to_mean_exprs=exprs,cell_to=cell_type)
      FilterTable<-rbind(FilterTable_1,FilterTable_2)
    }else if(datatype=='DEG'){
      gene_list_1<-data_1
      if(is.null(data_2)){
        gene_list_2<-gene_list_1
      }else{
        gene_list_2<-data_2
      }
      ligand_ind<-which(database$ligand %in% gene_list_1$gene)
      receptor_ind<-which(database$receptor %in% gene_list_2$gene)
      ind<-intersect(ligand_ind,receptor_ind)
      FilterTable_1<-database[ind,c('ligand','receptor')] %>%
        left_join(gene_list_1[,c('gene','logFC','q.value','cell_type')],by=c('ligand'='gene')) %>%
        dplyr::rename(cell_from_logFC=logFC,cell_from_q.value=q.value,cell_from=cell_type) %>%
        left_join(gene_list_2[,c('gene','logFC','q.value','cell_type')],by=c('receptor'='gene')) %>%
        dplyr::rename(cell_to_logFC=logFC,cell_to_q.value=q.value,cell_to=cell_type)
      ligand_ind<-which(database$ligand %in% gene_list_2$gene)
      receptor_ind<-which(database$receptor %in% gene_list_1$gene)
      ind<-intersect(ligand_ind,receptor_ind)
      FilterTable_2<-database[ind,c('ligand','receptor')] %>%
        left_join(gene_list_2[,c('gene','logFC','q.value','cell_type')],by=c('ligand'='gene')) %>%
        dplyr::rename(cell_from_logFC=logFC,cell_from_q.value=q.value,cell_from=cell_type) %>%
        left_join(gene_list_1[,c('gene','logFC','q.value','cell_type')],by=c('receptor'='gene')) %>%
        dplyr::rename(cell_to_logFC=logFC,cell_to_q.value=q.value,cell_to=cell_type)
      FilterTable<-rbind(FilterTable_1,FilterTable_2)
    }else{
      stop('Error: invalid data type')
    }
    
    FilterTable<-FilterTable[!duplicated(FilterTable),]
    res<-as.data.frame(FilterTable) %>% dplyr::rename(ligand=ligand,receptor=receptor)
    if(datatype=='DEG'){
      res<-res[!(res$cell_from_logFC==0.0001 & res$cell_to_logFC==0.0001),]
    }
    res<-res %>% mutate(comm_type=comm_type)
    return(res)
  }
  
  tryCatch({
    gene_names = "symbol"
    top_genes = 50
    organism = "human"
    stats = "mean"
    databaseFile = "union_LR_database"
    referencePath=innerpath
    
    database <- read.table(paste(referencePath,"/",databaseFile,".txt",sep=''),sep='\t',header=T,as.is=T)
    ###
    # data <- UserSeuratObject@assays$RNA@data
    # data <- as.data.frame(data)
    # meta0 <- as.data.frame(UserSeuratObject@active.ident)
    # meta <- data.frame(rownames(meta0),as.matrix(meta0[,1,drop=F]),stringsAsFactors = F)
    # colnames(meta)=c("cell","cell_type")
    
    ##del Unknown
    meta=meta[which(meta$cell_type!="Unknown"),,drop=F]
    inter_ID <- intersect(meta$cell,colnames(data))
    ####
    if(length(inter_ID)==0){
      stopMessage <- "No id match please check."
      out <- list(error_attention = paste0("error_attention: ",stopMessage))
      return(out)
    }
    meta <- meta[meta$cell %in% inter_ID,,drop=F]
    data <- data[,meta$cell,drop=F]
    
    data <- as.data.frame(t(data),stringsAsFactors=F)
    data$cell_type <- meta$cell_type
    highly_exprs_genes <- rawParse(data,top_genes = as.numeric(top_genes),stats)
    
    database <- database[(database$ligand %in% highly_exprs_genes$gene)&(database$receptor%in%highly_exprs_genes$gene),]
    comm_list<-unique(database$classification)
    
    res_cat <- do.call(rbind,lapply(comm_list,function(x) my_FindLR(highly_exprs_genes,datatype='mean count',comm_type=x,database = database)))
    
    if(sum(dim(res_cat)[1])==0){
      stopMessage <- "No result please check."
      out <- list(error_attention = paste0("error_attention: ",stopMessage))
      return(out)
    }else{
      
      res_cat$score <- as.numeric(res_cat$cell_from_mean_exprs)*as.numeric(res_cat$cell_to_mean_exprs)
      #######======================================output table
      res_cat <- res_cat[res_cat$score>0,,drop=F]
      if(sum(dim(res_cat)[1])==0){
        stopMessage <- "No result please check."
        out <- list(error_attention = paste0("error_attention: ",stopMessage))
        return(out)
      }else{
        res_output <- res_cat[,c("ligand","cell_from","cell_from_mean_exprs",
                                 "receptor","cell_to","cell_to_mean_exprs","comm_type","score")]
        colnames(res_output)[c(3,6,7)] <- c("Mean_exp1","Mean_exp2","Function")
        res_output[,3] <- round(as.numeric(res_output[,3]),4)
        res_output[,6] <- round(as.numeric(res_output[,6]),4)
        
        res_output_df <- as.data.frame(res_output)
        output <- list(data = res_output_df)
        write.table(output,paste(filePath,paste0(methodname,"_Res_italktable.txt"),sep="/"),row.names = F,col.names = T,sep = "\t",quote = F)
        res_output_df_display <- res_output_df %>% group_by(ligand,receptor) %>% arrange(desc(score)) %>% top_n(n=10,wt=score)
        res_output_df_display <- as.data.frame(res_output_df_display)
        #res_output_df_display <- res_output_df_display[1:10,]
        output_display <- list(data = res_output_df_display)
        jsoncars <- toJSON(output_display, pretty=TRUE)
        cat(jsoncars, file = paste(filePath,paste0(methodname,"_iTALK_method_top_genes_r_re.txt"),sep='/'), fill = FALSE, labels = NULL, append = FALSE)
        
        ####circos
        gene_pairs <- paste(res_cat[,"ligand"],res_cat[,"receptor"],sep='_')
        res_cat2 <- cbind(gene_pairs,res_cat)
        cell_count <- aggregate(res_cat2[,"gene_pairs"],list(res_cat2[,"cell_from"],res_cat2[,"cell_to"]),length)
        colnames(cell_count) <- c("cell_from","cell_to","number")
        
        cell_all_name=unique(c(cell_count$cell_from,cell_count$cell_to))
        
        # #cell order
        # c_order <- read.table(paste(referencePath,"/cellType_inOrder.txt",sep=''),sep='\t',header=T,as.is=T)
        # c_order <- as.matrix(c_order)
        # cell_all_name_order <- na.omit(cell_all_name[match(c_order,cell_all_name)])
        cell_all_name_order <- cell_all_name
        value=c()
        for (i in 1:length(cell_all_name_order)){
          c0=cell_all_name_order[i]
          c0_data=cell_count[which((cell_count$cell_from==c0)|(cell_count$cell_to==c0)),]
          value=c(value,sum(c0_data$number))
        }
        quan <- quantile(value)
        
        symbolSize=rep(20,times=length(value))
        symbolSize[value>quan[2] & value<=quan[3]] <- 30
        symbolSize[value>quan[3] & value<=quan[4]] <- 40
        symbolSize[value>quan[4] & value<=quan[5]] <- 50
        
        ID <- as.character(0:(length(cell_all_name_order)-1))
        category<- 0:(length(cell_all_name_order)-1)
        node=data.frame(id=ID,name=cell_all_name_order,symbolSize=symbolSize,value=value,category=category)
        
        #node colour
        n_colour <- color
        n_colour2 <- n_colour[cell_all_name_order,1]
        n_colour2_s <- paste(n_colour2,collapse = ",")
        ###link
        source=c()
        target=c()
        for (i in 1:dim(cell_count)[1]){
          s0=cell_count[i,1]
          t0=cell_count[i,2]
          s0_id=node[which(node$name==s0),]$id
          t0_id=node[which(node$name==t0),]$id
          source=c(source, as.character(s0_id))
          target=c(target, as.character(t0_id))
        }
        
        links=data.frame(source=source,target=target)
        ##category2
        category_all=data.frame(name=cell_all_name_order)
        
        circos_data <- list(nodes = node,links = links,categories = category_all)
        jsoncars_circos <- toJSON(circos_data, pretty=TRUE)
        cat(jsoncars_circos, file = paste(filePath,paste0(methodname,"_iTALK_method_top_genes_r_re_circle.json"),sep='/'), fill = FALSE, labels = NULL, append = FALSE)
        #riverplot
        res_cat$cell_pairs <- paste(res_cat[,"cell_from"],res_cat[,"cell_to"],sep='_')
        gene_count <- aggregate(res_cat[,"cell_pairs"],list(res_cat[,"ligand"],res_cat[,"receptor"]),length)
        gene_count_sort <- gene_count[order(gene_count[,3],decreasing = T),,drop=F]
        
        if(nrow(gene_count_sort)>=50){
          gene_plot <- gene_count_sort[1:50,c(1,2)]
          plot_data <- res_cat[res_cat$ligand %in% gene_plot[,1]&res_cat$receptor %in% gene_plot[,2],c("cell_from","ligand","comm_type","receptor","cell_to")]
        }else{
          plot_data <- res_cat[,c("cell_from","ligand","comm_type","receptor","cell_to"),drop=F]
        }
        
        plot_data$cell_from <- paste(plot_data$cell_from,"(F)",sep='')
        plot_data$cell_to <- paste(plot_data$cell_to,"(T)",sep='')
        plot_data$ligand <- paste(plot_data$ligand,"(L)",sep='')
        plot_data$receptor <- paste(plot_data$receptor,"(R)",sep='')
        
        node <- unique(cbind(c(plot_data$cell_from,plot_data$ligand,plot_data$comm_type,
                               plot_data$receptor,plot_data$cell_to),
                             c(rep(0,length(plot_data$cell_from)),rep(1,length(plot_data$ligand)),
                               rep(2,length(plot_data$comm_type)),rep(3,length(plot_data$receptor)),
                               rep(4,length(plot_data$cell_to)))))
        
        node_ss <- apply(node,1,function(x){
          s1 <- paste('"name": "',x[1],'"',sep='')
          s2 <- paste('"depth": ',x[2],sep='')
          if(grepl("\\(F\\)",x[1])){
            cellF <- gsub("\\(F\\)","",x)
            col <- n_colour[rownames(n_colour) %in% cellF,1]
            s3 <- paste('"itemStyle": {"color": "',col,'"}',sep='')
          }else if(grepl("\\(T\\)",x[1])){
            cellT <- gsub("\\(T\\)","",x)
            col <- n_colour[rownames(n_colour)  %in% cellT,1]
            s3 <- paste('"itemStyle": {"color": "',col,'"}',sep='')
          }else{
            s3 <- NULL
          }
          if(is.null(s3)){
            ss <- paste(s1,s2,sep=',')
          }else{
            ss <- paste(s1,s2,s3,sep = ",")
          }
          ss2 <- paste('{',ss,'}',sep='')
        })
        node_ss2 <- paste(unlist(node_ss),collapse = ",")
        node_json <- paste('"nodes": [',node_ss2,']',sep='')
        
        plot_data$index <- 1  
        data_cell_from <- aggregate(plot_data[,"index"],list(plot_data[,c("cell_from")],plot_data[,c("ligand")]),length)
        colnames(data_cell_from) <- c("source","target","value") 
        
        data_ligand <- aggregate(plot_data[,"index"],list(plot_data[,c("ligand")],plot_data[,c("comm_type")]),length)
        colnames(data_ligand) <- c("source","target","value") 
        
        data_receptor <- aggregate(plot_data[,"index"],list(plot_data[,c("comm_type")],plot_data[,c("receptor")]),length)
        colnames(data_receptor) <- c("source","target","value")
        
        data_to <- aggregate(plot_data[,"index"],list(plot_data[,c("receptor")],plot_data[,c("cell_to")]),length)
        colnames(data_to) <- c("source","target","value")
        
        link <- Reduce(rbind,list(data_cell_from,data_ligand,data_receptor,data_to)) 
        #link json
        link_ss <- apply(link,1,function(x){
          ss <- paste('{"source": "',x[1],'","target": "',x[2],'",','"value": ',x[3],'}',sep='')
        })
        link_ss2 <- paste(link_ss,collapse = ",")
        link_json <- paste('"links": [',link_ss2,']',sep='')
        output <- paste('{',node_json,',',link_json,'}',sep='')
        cat(output, file = paste(filePath,paste0(methodname,"_iTALK_method_top_genes_r_re_riverplot.json"),sep='/'), fill = FALSE, labels = NULL, append = FALSE)
        
        #####
        download_table=paste0(methodname,"_Res_italktable.txt")
        Res_circos_file=paste0(methodname,"_iTALK_method_top_genes_r_re_circle.json")
        Res_circos_color=n_colour2_s
        Res_tablefile=paste0(methodname,"_iTALK_method_top_genes_r_re.txt")
        Res_riverplot_file=paste0(methodname,"_iTALK_method_top_genes_r_re_riverplot.json")
        
        out <- list(download_table=download_table,
                    Res_circos_file=Res_circos_file,
                    Res_circos_color=Res_circos_color,
                    Res_tablefile=Res_tablefile,
                    Res_riverplot_file=Res_riverplot_file,
                    error_attention = "error_attention: no")
        
        return(out)
      }
    }
  },error=function(e){
    stopMessage <- "something wrong."
    out <- list(error_attention = paste0("error_attention: ",stopMessage))
    return(out)
  })
}

blackGeneWithoutDIG<-function(SeuratObj,dir_blackGene){
  mito.genes <- grep(pattern = "^MT-", rownames(SeuratObj), value = TRUE)
  ribo.genes <- grep(pattern = "^RP([0-9]+-|[LS])", rownames(SeuratObj), value = TRUE)
  immunoglobulin.genes<-read.table(paste0(dir_blackGene,"/immunoglobulin_gene.txt"))$V1
  proliferation.genes<-read.table(paste0(dir_blackGene,"/proliferation_genes.txt"))$V1
  #TCR.genes<-read.table(paste0(dir_black,"/TCR_gene.txt"))$V1
  out.genes<-c(mito.genes,ribo.genes,immunoglobulin.genes,proliferation.genes)
  return(out.genes)
}

marker_detect<-function(gene,cluster,seu,tpm){
  
  #####Extract cell
  library(Seurat)
  cell1<-colnames(seu)[which(seu@meta.data$cell_type==cluster)]
  cell2<-colnames(seu)[which(seu@meta.data$cell_type!=cluster)]
  count<-GetAssayData(seu,"counts")
  #####The first condition
  condition1<-sum(count[gene,]>=3)>=3 
  
  #####The second condition
  exp1<-tpm[gene,cell1]
  exp2<-tpm[gene,cell2]
  p<-wilcox.test(as.numeric(exp1),as.numeric(exp2))$p.value
  p_adj<-p.adjust(p,method="fdr")
  condition2<-p_adj<0.05
  
  #####The third condition
  clu<-names(table(seu@meta.data$cell_type))
  avg1<-sapply(clu,function(x){
    mean(t(tpm[gene,colnames(seu)[which(seu@meta.data$cell_type==x)]]))
  })
  max<-names(avg1)[which.max(avg1)]
  condition3<-max==as.character(cluster)
  
  #####The fourth condition
  condition4<-unname((max(avg1)+50)/(sort(avg1,decreasing = T)[2]+50)>1.1)
  
  #Intersection of four conditions
  if(condition1 & condition2 & condition3 & condition4){
    m<-data.frame(gene=gene,cluster=cluster)
    return(m)
  }
}

marker_detect_cosg<-function(gene_inters,cluster,seu,tpm){
  
  #####Extract cell
  cell1<-colnames(seu)[which(seu@meta.data$cell_type==cluster)]
  cell2<-colnames(seu)[which(seu@meta.data$cell_type!=cluster)]
  count<-seu@assays$SCT@counts
  #gene_inters=intersect(gene_inters,rownames(count))
  sig_gene=c()
  for (jj in 1:length(gene_inters)){
    gene=gene_inters[jj]
    #####The first condition
    condition1<-sum(count[gene,]>=3)>=3 
    
    #####The second condition
    exp1<-tpm[gene,cell1]
    exp2<-tpm[gene,cell2]
    p<-wilcox.test(as.numeric(exp1),as.numeric(exp2))$p.value
    p_adj<-p.adjust(p,method="fdr")
    condition2<-p_adj<0.05
    
    #####The third condition
    clu<-names(table(seu@meta.data$cell_type))
    avg1<-sapply(clu,function(x){
      mean(t(tpm[gene,colnames(seu)[which(seu@meta.data$cell_type==x)]]))
    })
    max<-names(avg1)[which.max(avg1)]
    condition3<-max==as.character(cluster)
    
    #####The fourth condition
    condition4<-unname((max(avg1)+50)/(sort(avg1,decreasing = T)[2]+50)>1.1)
    
    #Intersection of four conditions
    if(condition1 & condition2 & condition3 & condition4){
      #m<-data.frame(gene=gene,cluster=cluster)
      sig_gene=c(sig_gene,gene)
    }
  }
  df0=data.frame(sig_gene=sig_gene)
  if(dim(df0)[1]>0){
    df0$celltype=cluster
    return(df0)
  }else{
    return("nosig")
  }
}

cosg_marker_wilcox<-function(seurat_obj,celltype_marker_cosg){
  celltype_marker_u<-unique(as.vector(celltype_marker_cosg))
  mat<-as.matrix(GetAssayData(seurat_obj,"data")[celltype_marker_u,])
  cell_to_celltype<-seurat_obj@meta.data
  cell_to_celltype$cellname=rownames(seurat_obj@meta.data)
  cell_to_celltype<-cell_to_celltype[,c("cellname","cell_type")]
  colnames(cell_to_celltype)=c("cellname","celltype")
  ##mat: seurat count mat
  ##celltype_marker_cosg: marker of celltype 
  ##cell_to_celltype: cellname of celltype
  cellType_all<-c()
  Marker_all<-c()
  p_all<-c()
  fdr_all<-c()
  FC_all<-c()
  cell_to_celltype<-cell_to_celltype[as.character(intersect(cell_to_celltype$cellname,colnames(mat))),]
  celltype_all<-as.character(unique(cell_to_celltype$celltype))
  
  for (i in 1:length(celltype_all)){
    #cat(i)
    #i=1
    ct0<-as.character(celltype_all[i])
    
    ct0_markers<-unname(celltype_marker_cosg[ct0,])
    p0<-c()
    dfr0<-c()
    fc0<-c()
    for (j in 1:length(ct0_markers)){
      #cat(j)
      #j=1
      cto_marker0=ct0_markers[j]
      ct0_exp=unname(mat[cto_marker0,as.character(cell_to_celltype[which(cell_to_celltype$celltype==ct0),]$cellname)])
      ct0_exp_other=unname(mat[cto_marker0,as.character(cell_to_celltype[which(cell_to_celltype$celltype!=ct0),]$cellname)])
      w_re=wilcox.test(ct0_exp,ct0_exp_other,alternative="greater")
      p0<-c(p0,w_re$p.value)
      if (mean(ct0_exp_other)==0){
        fc=100000000
      }else{
        fc=mean(ct0_exp)/mean(ct0_exp_other)
      }
      
      fc0<-c(fc0,fc)
    }
    dfr0<-c(dfr0,p.adjust(p0,method="fdr",length(p0)))
    
    cellType_all<-c(cellType_all,rep(ct0,length(ct0_markers)))
    Marker_all<-c(Marker_all,ct0_markers)
    p_all<-c(p_all,p0)
    fdr_all<-c(fdr_all,dfr0)
    FC_all<-c(FC_all,fc0)
    
  }
  wilcox_re_df=data.frame(Celltype=cellType_all,MarkerGene=Marker_all,P_value=p_all,FC_value=FC_all,FDR=fdr_all)
  
  return(wilcox_re_df)
}

###method
gene_infor_heatmap<-function(filePath,method,SeuratObject,celltype_marker_cosg,color,show_gene_every,show_cell_every){
  ##filePath:user file path
  ##method:method name
  ##SeuratObject: SeuratObject after chenge idents
  ##celltype_marker_cosg: result table of method identify_celltypeMarker_COSG
  ##color:used color
  ##show_gene_every: top n marker gene of every celltype
  ##show_cell_every:random n cells show in the heatmap 
  library(ggplot2)
  filePath<-filePath
  method<-method
  SeuratObject<-SeuratObject
  markers<-celltype_marker_cosg
  color<-color
  show_gene_every<-show_gene_every
  show_cell_every<-show_cell_every
  
  test=Seurat::Idents(object = SeuratObject)
  test_df <- data.frame(cells=names(test),cellTypes=unname(test))
  cells_plot <- by(test_df$cells,test_df$cellTypes,function(x){if(length(x)>show_cell_every){return(x[sample(1:length(x),show_cell_every)])}else{return(x)}})
  colors_use <- as.character(color[names(cells_plot),])
  topn <- ifelse(100%/%length(cells_plot)>show_gene_every,show_gene_every,100%/%length(cells_plot))
  markers_topn <- by(markers$marker,markers$celltype,function(x){return(as.character(x[1:topn]))})
  
  p=DoHeatmap(SeuratObject, features = unlist(markers_topn),cells = unlist(cells_plot),label=F,lines.width =1,group.colors =colors_use) +
    theme(legend.position="bottom",axis.text  = element_text( size=3,colour = "black"),
          legend.title = element_blank(),legend.key.size=unit(3,'mm'),legend.key.width=unit(8,'mm'),
          legend.text = element_text(size = 8),plot.title = element_text(hjust = 0.5)) + ggtitle("The expression of markers")
  ggsave(paste0(filePath,"/",method,"_heatmap.png"),p, width = 3000,  height = 1500, 
         units = "px",  bg = "white",  dpi = 300)
}

marker_table_and_download <- function(data0,name0,path0){
  data_json <- toJSON(data0, pretty=TRUE)
  cat(str_c('{\"data\": ',data_json,'}'), file = paste0(path0,"/",name0,"_table.txt"), fill = FALSE, labels = NULL, append = FALSE)
  write.table(data0,paste0(path0,'/',name0,'_table_Download.txt'),sep='\t',quote = F,row.names = F)
}
