mouse_datasets="GSE149069,GSE131776,GSE97310,GSE198833,E_MTAB_8810,GSE193746,GSE213337,GSE100861,GSE122930,syn26282495,GSE155882,GSE137167,GSE118545,GSE168742,E_MTAB_7376,GSE153480,GSE157244,GSE135310,GSE163465,GSE132880,E_MTAB_7895,GSE128628,GSE163129,GSE152122,GSE136088,GSE130699,GSE213486,E_MTAB_6173,GSE157444,E_MTAB_7869,GSE130710,GSE158941,PRJNA489304,PRJNA562135 ,GSE122706,GSE120064,GSE179276,GSE190856,GSE207363";
searchAtlas_infor="";
$.ajaxSettings.async = false;
$.getJSON("0_files/searchDataset_infor.txt", "", function(data_re) {
	searchAtlas_infor=data_re;
});
ats=searchAtlas_infor['datasets'].split(',');
content_innerHTML(ats,searchAtlas_infor);


function content_innerHTML(ats,searchAtlas_infor){
	var content_infor="";
	for (var j=0;j<ats.length;j++){
		ats0=ats[j];
		ats0_species=searchAtlas_infor[ats0+"_species"];
		ats0_tec=searchAtlas_infor[ats0+"_tec"];
		ats0_tissue=searchAtlas_infor[ats0+"_tissue"];
		ats0_disease=searchAtlas_infor[ats0+"_disease"];
		ats0_cellNum=searchAtlas_infor[ats0+"_cellNum"];
		ats0_geneNum=searchAtlas_infor[ats0+"_geneNum"];
		ats0_celltypeNum=searchAtlas_infor[ats0+"_celltypeNum"];
		ats0_journal=searchAtlas_infor[ats0+"_journal"];
		ats0_journal_http=searchAtlas_infor[ats0+"_journal_http"];
		
		if(mouse_datasets.indexOf(ats0)!= -1){
			content_infor=content_infor+'<div class="col-md-6 col-sm-6"><div class="panel panel-success"><div class="panel-heading"><table style="width:100%;">'+
			'<tr><td><button class="btn btn-danger panel-up-ww" > <i class="fa-thin fa-mouse-field" ></i> '+ats0_species+
			'</button></td><td> <button class="btn btn-warning panel-up-ww"><i class="fa-solid fa-dna panel-li"></i> '+ats0_tec+
			'</button></td><td> <button class="btn btn-warning panel-up-ww"><i class="fa-solid fa-heart-pulse panel-li"></i> '+ats0_tissue+
			'</button></td><td> <button class="btn btn-warning panel-up-ww"><i class="fa-solid fa-heart-pulse panel-li"></i> '+ats0_disease+
			'</tr></table></div><div class="panel-body"><table style="width:100%;"><tr><td><span> <strong class="panel-body-font"> '+ats0_cellNum+
			'</strong> Cells </span></td><td><span> <strong class="panel-body-font"> '+ats0_geneNum+
			'</strong> Genes </span></td><td><span> <strong class="panel-body-font"> '+ats0_celltypeNum+
			'</strong> Celltypes</span></td></tr></table></div><div class="panel-footer"><span><button class="btn btn-warning panel-down-ww"> <a class="panel-down-ww-a" href="DatasetDetailsMus.jsp?daset='+ats0+
			'&annotationType=small"><i class="fa-solid fa-binoculars panel-li"></i> View</a></button></span><span style="float:right;"> <a class="panel-down-ww-dataset" href="'+ats0_journal_http+'">'+ats0_journal+
			'</a></span></div></div></div>';
		}else{
		
			content_infor=content_infor+'<div class="col-md-6 col-sm-6"><div class="panel panel-success"><div class="panel-heading"><table style="width:100%;">'+
			'<tr><td><button class="btn btn-danger panel-up-ww" > <i class="fa-sharp fa-solid fa-person panel-li" ></i>'+ats0_species+
			'</button></td><td> <button class="btn btn-warning panel-up-ww"><i class="fa-solid fa-dna panel-li"></i>'+ats0_tec+
			'</button></td><td> <button class="btn btn-warning panel-up-ww"><i class="fa-solid fa-heart-pulse panel-li"></i>'+ats0_tissue+
			'</button></td><td> <button class="btn btn-warning panel-up-ww"><i class="fa-solid fa-heart-pulse panel-li"></i>'+ats0_disease+
			'</tr></table></div><div class="panel-body"><table style="width:100%;"><tr><td><span> <strong class="panel-body-font">'+ats0_cellNum+
			'</strong> Cells </span></td><td><span> <strong class="panel-body-font">'+ats0_geneNum+
			'</strong> Genes </span></td><td><span> <strong class="panel-body-font">'+ats0_celltypeNum+
			'</strong> Celltypes</span></td></tr></table></div><div class="panel-footer"><span><button class="btn btn-warning panel-down-ww"> <a class="panel-down-ww-a" href="DatasetDetails.jsp?daset='+ats0+
			'&annotationType=small"><i class="fa-solid fa-binoculars panel-li"></i> View</a></button></span><span style="float:right;"> <a class="panel-down-ww-dataset" href="'+ats0_journal_http+'">'+ats0_journal+
			'</a></span></div></div></div>';
		}
	}
	
	//console.log(content_infor);
	document.getElementById("dataset_content").innerHTML=content_infor;
}
function searchdatasets(){
	var key=document.getElementById("datasets").value;
	var searchType="datasets";
	key=$.trim(key);
	if(key.length==0){
		alert("INPUT A KEY WROLD FIRST !");
		return false;
	}
	
	var xmlHttp=new XMLHttpRequest();
	xmlHttp.onreadystatechange =function(){
		if(xmlHttp.readyState == 4 && xmlHttp.status == 200){
			var returnData=xmlHttp.responseText;
			var jsonobj=JSON.parse(returnData);
			if(jsonobj.error_attention=="no"){
				////
				var datasets_re=jsonobj.ids.split(";");
				content_innerHTML(datasets_re,searchAtlas_infor);
				
			}else{
				alert("NO RESULT !");
				return false;
			}
				}
			}

	var param="key="+key+"&searchType="+searchType;
	xmlHttp.open("get","mysqlFuzzyMatching.jsp?"+param,true);
	xmlHttp.send();
}