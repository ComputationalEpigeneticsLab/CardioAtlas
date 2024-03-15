###ID_new : Task ID
###filePath ：user upload file path
###fileName ：user upload file fileName
###innerpath ：base file path eg:job_ID
SeuratQC <- function(ID_new,filePath,fileName,innerpath,email_address,share_reference,resolution){
suppressMessages({
  library('Seurat')
})
  filePath<-filePath
  fileName<-fileName
  innerpath<-innerpath
  ID_new<-ID_new
  email_address<-email_address
  share_reference<-share_reference
  resolution<-resolution
## updata Job_ID.txt, append a new job and state is run
Task_ID <- as.matrix(read.table(paste0(innerpath,"/","Job_ID.txt"),header = F,sep = "\t",check.names = F,fill = T))
Task_ID_new <- rbind(Task_ID,c(ID_new,"run"))
write.table(Task_ID_new,paste0(innerpath,"/Job_ID.txt"),quote = F,sep = "\t",row.names = F,col.names = F)
tryCatch({
###read mian table ###
data <- as.matrix(read.table(paste0(filePath,"/",fileName),header = T,sep = "\t",as.is=TRUE,quote = "",row.names = 1))
gene_num<-dim(data)[1]
cell_num<-dim(data)[2]
DataSeuratObject <- CreateSeuratObject(counts = data)

### basic qc min.cells min.features ###
DataSeuratObject <- CreateSeuratObject(counts = data, project = "UserObject", min.cells = 3, min.features = 200)
#### main qc ####
DataSeuratObject[["percent.mt"]] <- PercentageFeatureSet(DataSeuratObject, pattern = "^MT-")
##VlnPlot(DataSeuratObject, features = c("nFeature_RNA", "nCount_RNA", "percent.mt"), ncol = 3)
##DataSeuratObject@meta.data[1:3,]
cell_num=dim(DataSeuratObject@meta.data)[1]
###nFeature_RNA
violin_data_nFeature_RNA=data.frame(violin_y=DataSeuratObject@meta.data$nFeature_RNA,violin_x=rep("nFeature RNA",cell_num))
write.table(violin_data_nFeature_RNA,paste0(filePath,"/","QC_violin_nFeature_RNA.csv"),quote=F,row.names=F,col.names=T,sep=",")
###nCount_RNA
violin_data_nCount_RNA=data.frame(violin_y=DataSeuratObject@meta.data$nCount_RNA,violin_x=rep("nCount RNA",cell_num))
write.table(violin_data_nCount_RNA,paste0(filePath,"/","QC_violin_nCount_RNA.csv"),quote=F,row.names=F,col.names=T,sep=",")
###percent.mt
violin_data_percent.mt=data.frame(violin_y=DataSeuratObject@meta.data$percent.mt,violin_x=rep("percent MT",cell_num))
write.table(violin_data_percent.mt,paste0(filePath,"/","QC_violin_percent_mt.csv"),quote=F,row.names=F,col.names=T,sep=",")
###RDS for next step
saveRDS(DataSeuratObject, file = paste0(filePath,"/","UserSeuratObjectQC.rds"))
####out put qc_re.txt#####
qc_violin_nFeature_RNA<-"QC_violin_nFeature_RNA.csv"
slider_nFeature_max<-max(violin_data_nFeature_RNA$violin_y)
slider_nFeature_from<-500 ##this is defeat value 
if(slider_nFeature_from>slider_nFeature_max){
  slider_nFeature_from<-0
}
slider_nFeature_to<-5000 ##this is defeat value 
if(slider_nFeature_to>slider_nFeature_max){
  slider_nFeature_to<-slider_nFeature_max
}

qc_violin_nCount_RNA<-"QC_violin_nCount_RNA.csv"
slider_nCount_max<-max(violin_data_nCount_RNA$violin_y)
slider_nCount_from<-2000 ##this is defeat value 
if(slider_nCount_from>slider_nCount_max){
  slider_nCount_from<-0
}
slider_nCount_to<-40000 ##this is defeat value 
if(slider_nCount_to>slider_nCount_max){
  slider_nCount_to<-slider_nCount_max
}


qc_violin_percent_mt<-"QC_violin_percent_mt.csv"
slider_mt_max<-round(max(violin_data_percent.mt$violin_y),4)
slider_mt_from<-0
slider_mt_to<-30 ##this is defeat value 
if(slider_mt_to>slider_mt_max){
  slider_mt_to<-slider_mt_max
}

error_attention<-"no"
re_qc <- paste0("{","\n",
'"UserTaskID" :','"',ID_new,'",',"\n",
'"email_address" :','"',email_address,'",',"\n",
'"share_reference" :','"',share_reference,'",',"\n",
'"resolution" :','"',resolution,'",',"\n",
'"fileName" :','"',fileName,'",',"\n",
'"gene_num" :','"',gene_num,'",',"\n",
'"cell_num" :','"',cell_num,'",',"\n",
              '"qc_violin_nFeature_RNA" :','"',qc_violin_nFeature_RNA,'",',"\n",
              '"qc_violin_nCount_RNA" :','"',qc_violin_nCount_RNA,'",',"\n",
              '"qc_violin_percent_mt" :','"',qc_violin_percent_mt,'",',"\n",
             '"slider_nFeature_max" :','"',slider_nFeature_max,'",',"\n",
             '"slider_nFeature_from" :','"',slider_nFeature_from,'",',"\n",
             '"slider_nFeature_to" :','"',slider_nFeature_to,'",',"\n",
             '"slider_nCount_max" :','"',slider_nCount_max,'",',"\n",
             '"slider_nCount_from" :','"',slider_nCount_from,'",',"\n",
             '"slider_nCount_to" :','"',slider_nCount_to,'",',"\n",
              '"slider_mt_max" :','"',slider_mt_max,'",',"\n",
              '"slider_mt_from" :','"',slider_mt_from,'",',"\n",
             '"slider_mt_to" :','"',slider_mt_to,'",',"\n",
              '"error_attention" :','"',error_attention,'"',"\n",
             '}'
                         
)

write.table(re_qc,paste0(filePath,"/","qc_re.txt"),quote = F,sep = "\t",row.names = F,col.names = F)
stopMessage<-"no"
result_message <- paste0("{",'"error_attention" :','"',stopMessage,'"}')
return(result_message)
},error = function(e){
####change job state success
  Task_ID <- as.matrix(read.table(paste0(innerpath,"/Job_ID.txt"),header = F,sep = "\t",check.names = F,fill = T))
  Task_ID_new <- Task_ID
  Task_ID_new[which(Task_ID_new[,1]==ID_new),2] <- "dead"
  write.table(Task_ID_new,paste0(innerpath,"/Job_ID.txt"),quote = F,sep = "\t",row.names = F,col.names = F)
  stopMessage<-"something wrong"
  result_message <- paste0("{",'"error_attention" :','"',stopMessage,'"}')
  return(result_message)
})

}
