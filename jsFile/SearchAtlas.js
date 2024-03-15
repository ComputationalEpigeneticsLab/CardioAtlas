searchAtlas_infor="";
$.ajaxSettings.async = false;
$.getJSON("0_files/searchAtlas_infor.txt", "", function(data_re) {
	searchAtlas_infor=data_re;
});

ats=searchAtlas_infor['ats'].split(',');
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
		
		if(ats0.indexOf("human")!= -1){
			content_infor=content_infor+'<div class="col-md-6 col-sm-6"><div class="panel panel-success"><div class="panel-heading"><table style="width:100%;">'+
			'<tr><td><button class="btn btn-danger panel-up-ww" > <i class="fa-sharp fa-solid fa-person panel-li" ></i> '+ats0_species+
			'</button></td><td> <button class="btn btn-warning panel-up-ww"><i class="fa-solid fa-dna panel-li"></i> '+ats0_tec+
			'</button></td><td> <button class="btn btn-warning panel-up-ww"><i class="fa-solid fa-heart-pulse panel-li"></i> '+ats0_tissue+
			'</button></td><td> <button class="btn btn-warning panel-up-ww"><i class="fa-solid fa-heart-pulse panel-li"></i> '+ats0_disease+
			'</tr></table></div><div class="panel-body"><table style="width:100%;"><tr><td><span> <strong class="panel-body-font">'+ats0_cellNum+
			'</strong> Cells </span></td><td><span> <strong class="panel-body-font">'+ats0_geneNum+
			'</strong> Genes </span></td><td><span> <strong class="panel-body-font">'+ats0_celltypeNum+
			'</strong> Celltypes</span></td></tr></table></div><div class="panel-footer"><span><button class="btn btn-warning panel-down-ww"> <a class="panel-down-ww-a" href="AtlasDetails.jsp?ats='+ats0+
			'"><i class="fa-solid fa-binoculars panel-li"></i> View</a></button></span><span style="float:right;"><button class="btn btn-warning panel-down-ww">  <a class="panel-down-ww-a" href="downloadCopy.jsp?name='+ats0+
			'" <i class="fa-solid fa-download panel-li"></i> Download</a></button></span></div></div></div>';
		}else{
			content_infor=content_infor+'<div class="col-md-6 col-sm-6"><div class="panel panel-success"><div class="panel-heading"><table style="width:100%;">'+
			'<tr><td><button class="btn btn-danger panel-up-ww" > <i class="fa-thin fa-mouse-field"></i> '+ats0_species+
			'</button></td><td> <button class="btn btn-warning panel-up-ww"><i class="fa-solid fa-dna panel-li"></i> '+ats0_tec+
			'</button></td><td> <button class="btn btn-warning panel-up-ww"><i class="fa-solid fa-heart-pulse panel-li"></i> '+ats0_tissue+
			'</button></td><td> <button class="btn btn-warning panel-up-ww"><i class="fa-solid fa-heart-pulse panel-li"></i> '+ats0_disease+
			'</tr></table></div><div class="panel-body"><table style="width:100%;"><tr><td><span> <strong class="panel-body-font"> '+ats0_cellNum+
			'</strong> Cells </span></td><td><span> <strong class="panel-body-font"> '+ats0_geneNum+
			'</strong> Genes </span></td><td><span> <strong class="panel-body-font"> '+ats0_celltypeNum+
			'</strong> Celltypes</span></td></tr></table></div><div class="panel-footer"><span><button class="btn btn-warning panel-down-ww"> <a class="panel-down-ww-a" href="AtlasDetailsMus.jsp?ats='+ats0+
			'"><i class="fa-solid fa-binoculars panel-li"></i> View</a></button></span><span style="float:right;"><button class="btn btn-warning panel-down-ww">  <a class="panel-down-ww-a" href="downloadCopy.jsp?name='+ats0+
			'" <i class="fa-solid fa-download panel-li"></i> Download</a></button></span></div></div></div>';
		}
	}
	//console.log(content_infor);
	document.getElementById("ats_content").innerHTML=content_infor;
}


function searchAts(){
	var key=document.getElementById("ats").value;
	var searchType="ats";
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
				var ats_re=jsonobj.ids.split(";");
				content_innerHTML(ats_re,searchAtlas_infor);
				
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