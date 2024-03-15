daset=document.getElementById("daset").value;
annotationType=document.getElementById("annotationType").value;

annotationType="big"
daset="dataset01";
datasetContent(daset,annotationType);

function datasetContent(daset,annotationType){
	webpath="example/";
	ats=daset;
	webpath=webpath+daset+"/"+annotationType;
	
	////overview summary with same height
	var overviewHeight=$("#overview").height();
	$("#summary").css("height",overviewHeight);
	//////////////////////summary infor///////////////////
	summary_re="";
	$.ajaxSettings.async = false;
	$.getJSON(webpath+"/summary_re.txt", "", function(data_re) {
		summary_re=data_re;
	});
	document.getElementById("Species").innerHTML=summary_re.Species;
	document.getElementById("Technology").innerHTML=summary_re.Technology;
	document.getElementById("Disease").innerHTML=summary_re.Disease;
	document.getElementById("Tissue").innerHTML=summary_re.Tissue;
	document.getElementById("Cell_Number").innerHTML=summary_re.Cell_Number;
	document.getElementById("Cell_Type_Number").innerHTML=summary_re.Cell_Type_Number;
	document.getElementById("Marker_Number").innerHTML=summary_re.Marker_Number;
	var downloadPath0="downloadCopy.jsp?path="+summary_re.daset+"&name=datasetDownload.rds";
	document.getElementById('dataset_download').href = downloadPath0;
	var downloadPath0="AtlasDetails.jsp?atlas="+summary_re.Annotation;
	document.getElementById('Annotation').href = downloadPath0;
	var Publication_infor=summary_re.Publication.split(",");
	document.getElementById("Publication").innerHTML=Publication_infor[0].toUpperCase();
	var downloadPath0="https://pubmed.ncbi.nlm.nih.gov/"+Publication_infor[1]+"/";
	document.getElementById('Publication').href = downloadPath0;
	//////////////////////celltype tsne &umap////////////////////
	celltype_re="";
	$.ajaxSettings.async = false;
	$.getJSON(webpath+"/celltype_re.txt", "", function(data_re) {
		celltype_re=data_re;
	});
	celltype_num=Number(celltype_re.cluster_num);
	celltype_name=celltype_re.cluster_name.split(",");
	
	data_tsen=[];
	shapes_tsen=[];
	data_umap=[];
	shapes_umap=[];
	for (var i=0;i<celltype_num;i++){
	//////tsne/////
		var json0={};
		json0["name"]=celltype_name[i];
		var x=celltype_name[i]+"_x_tsne";
		//console.log(x);
		//console.log(eval("celltype_re."+x));
		var y=celltype_name[i]+"_y_tsne";
		var x_array=celltype_re[x].split(",");
		var y_array=celltype_re[y].split(",");
		json0["x"]=x_array;
		json0["y"]=y_array;
		json0["mode"]='markers';
		var color=celltype_name[i]+"_color_tsne";
		json_marker={};
		json_marker["color"]=celltype_re[color];
		//json_marker["size"]=5;//点大小
		json0["marker"]=json_marker;
		data_tsen.push(json0);
		var json1={};
		json1["type"]='circle';
		json1["xref"]='x';
		json1["yref"]='y';
		json1["x0"]=Math.min.apply(null,x_array);
		json1["y0"]=Math.min.apply(null,y_array);
		json1["x1"]=Math.max.apply(null,x_array);
		json1["y1"]=Math.max.apply(null,y_array);
		json1["opacity"]=0.2;
		json1["fillcolor"]=celltype_re[color];
		var json_line={};
		json_line["color"]=celltype_re[color];
		json1["line"]=json_line;
		shapes_tsen.push(json1);
	//////umap/////
		var json0={};
		json0["name"]=celltype_name[i];
		var x=celltype_name[i]+"_x_umap";
		//console.log(x);
		//console.log(eval("celltype_re."+x));
		var y=celltype_name[i]+"_y_tsne";
		var x_array=celltype_re[x].split(",");
		var y_array=celltype_re[y].split(",");
		json0["x"]=x_array;
		json0["y"]=y_array;
		json0["mode"]='markers';
		var color=celltype_name[i]+"_color_umap";
		json_marker={};
		json_marker["color"]=celltype_re[color];
		//json_marker["size"]=5;//点大小
		json0["marker"]=json_marker;
		data_umap.push(json0);
	//////umap/////
		var json1={};
		json1["type"]='circle';
		json1["xref"]='x';
		json1["yref"]='y';
		json1["x0"]=Math.min.apply(null,x_array);
		json1["y0"]=Math.min.apply(null,y_array);
		json1["x1"]=Math.max.apply(null,x_array);
		json1["y1"]=Math.max.apply(null,y_array);
		json1["opacity"]=0.2;
		
		json1["fillcolor"]=celltype_re[color];
		
		var json_line={};
		json_line["color"]=celltype_re[color];
		json1["line"]=json_line;
		shapes_umap.push(json1);
	}
	tsen_umap_org(data_umap,shapes_umap,"umap","umap");
	tsen_umap_org(data_tsen,shapes_tsen,"tsne","tsne");
	console.log(data_tsen);
	console.log(shapes_tsen);
	cluster_re="";
	$.ajaxSettings.async = false;
	$.getJSON(webpath+"/cluster_re.txt", "", function(data_re) {
		cluster_re=data_re;
	});
	cluster_num=Number(cluster_re.cluster_num);
	cluster_name=cluster_re.cluster_name.split(",");
	
	data_tsen_cluster=[];
	shapes_tsen_cluster=[];
	data_umap_cluster=[];
	shapes_umap_cluster=[];
	for (var i=0;i<cluster_num;i++){
	//////tsne/////
		var json0={};
		json0["name"]=cluster_name[i];
		var x="cluster"+i+"_x_tsne";
		//console.log(x);
		//console.log(eval("cluster_re."+x));
		var y="cluster"+i+"_y_tsne";
		var x_array=cluster_re[x].split(",");
		var y_array=cluster_re[y].split(",");
		json0["x"]=x_array;
		json0["y"]=y_array;
		json0["mode"]='markers';
		var color="cluster"+i+"_color_tsne";
		json_marker={};
		json_marker["color"]=cluster_re[color];
		//json_marker["size"]=5;//点大小
		json0["marker"]=json_marker;
		data_tsen_cluster.push(json0);
		var json1={};
		json1["type"]='circle';
		json1["xref"]='x';
		json1["yref"]='y';
		json1["x0"]=Math.min.apply(null,x_array);
		json1["y0"]=Math.min.apply(null,y_array);
		json1["x1"]=Math.max.apply(null,x_array);
		json1["y1"]=Math.max.apply(null,y_array);
		json1["opacity"]=0.2;
		json1["fillcolor"]=cluster_re[color];
		var json_line={};
		json_line["color"]=cluster_re[color];
		json1["line"]=json_line;
		shapes_tsen_cluster.push(json1);
	//////umap/////
		var json0={};
		json0["name"]=cluster_name[i];
		var x="cluster"+i+"_x_umap";
		//console.log(x);
		//console.log(eval("cluster_re."+x));
		var y="cluster"+i+"_y_tsne";
		var x_array=cluster_re[x].split(",");
		var y_array=cluster_re[y].split(",");
		json0["x"]=x_array;
		json0["y"]=y_array;
		json0["mode"]='markers';
		var color="cluster"+i+"_color_umap";
		json_marker={};
		json_marker["color"]=cluster_re[color];
		//json_marker["size"]=5;//点大小
		json0["marker"]=json_marker;
		data_umap_cluster.push(json0);
	//////umap/////
		var json1={};
		json1["type"]='circle';
		json1["xref"]='x';
		json1["yref"]='y';
		json1["x0"]=Math.min.apply(null,x_array);
		json1["y0"]=Math.min.apply(null,y_array);
		json1["x1"]=Math.max.apply(null,x_array);
		json1["y1"]=Math.max.apply(null,y_array);
		json1["opacity"]=0.2;
		
		json1["fillcolor"]=cluster_re[color];
		var json_line={};
		json_line["color"]=cluster_re[color];
		json1["line"]=json_line;
		shapes_umap_cluster.push(json1);
	}
	/////////////////// Advanced content ///////////////////
	advance_re="";
	$.ajaxSettings.async = false;
	$.getJSON(webpath+"/advance_re.txt", "", function(data_re) {
		advance_re=data_re;
	});
	////////////1.cellDensityPlot
	cellinfor_barplot_all(advance_re,"cellDensityPlot");
	////////////2.cell cycle
	plotyPielot("pieCellCycle",advance_re.cell_cycle_pie_value.split(","),advance_re.cell_cycle_pie_label.split(","),"","");
	//table
	cycle_table(webpath+"/"+advance_re.cell_cycle_webTable);
	document.getElementById('tableCellCycle_download').href ="download_loading.jsp?path="+ webpath+"/"+advance_re.cell_cycle_webTableDownload+"&name=cellcyle_table.txt";
	////////////3.cellCorr
	cellCorr_heatmap_nosig(advance_re,"Correlation of Cell Type","HeatmapCellCorr");
	//table
	celltypeCorr_table(webpath+"/"+advance_re.cellTypeCorr_webTable);
	//table download
	document.getElementById('tableCellCorr_download').href ="download_loading.jsp?path="+ webpath+"/"+advance_re.cellTypeCorr_webTableDownload+"&name=cellcyle_table.txt";
	///////////4. cell cell comm
	cellcell_communication_table(webpath+"/"+advance_re.italk_tablefile_web,"tableCellCellCom");
	// 向download table中传参
	var downloadPath="download_loading.jsp?path="+webpath+"/"+advance_re.italk_download_table+"&name=cellcellCommunication.txt";
	document.getElementById('tableCellCellCom_download').href = downloadPath;
	// river
	echars_River_cellcell(webpath+"/"+advance_re.italk_riverplot_file,'RiverCellCellCom');
	///////////5. function GO-BP
	//table
	if(advance_re.GO_BP_enrich_table_web !="empty"){
		function_infor_enrich_table(webpath+"/"+advance_re.GO_BP_enrich_table_web,'tableGO');
		var downloadPath="download_loading.jsp?path="+webpath+"/"+advance_re.GO_BP_enrich_table_download+"&name=GO_BP_enrich_table_download.txt";
		document.getElementById('tableGO_download').href = downloadPath;
	}else{
		document.getElementById("tableGO").style.display="none";
		document.getElementById("GO-table").innerHTML="No sig result!";
	}
	//heatmap
	if(advance_re.GO_BP_enrich_sig_pair !="empty"){
		//sig
		function_infor_ssgsea_heatmap_havesig(advance_re,"ssGSEA scores of GO BP for each celltype(* p<0.05)","GO_BP");
	}else{
		//no sig
		function_infor_ssgsea_heatmap_nosig(advance_re,"ssGSEA scores of GO BP for each celltype","GO_BP");
	}
	///////////6. function KEGG
	//table
	if(advance_re.KEGG_enrich_table_web !="empty"){
		function_infor_enrich_table(webpath+"/"+advance_re.KEGG_enrich_table_web,'tableKEGG');
		var downloadPath="download_loading.jsp?path="+webpath+"/"+advance_re.KEGG_enrich_table_download+"&name=KEGG_enrich_table_download.txt";
		document.getElementById('tableKEGG_download').href = downloadPath;
	}else{
		document.getElementById("tableKEGG").style.display="none";
		document.getElementById("KEGG-table").innerHTML="No sig result!";
	}
	//heatmap
	if(advance_re.KEGG_enrich_sig_pair !="empty"){
		//sig
		function_infor_ssgsea_heatmap_havesig(advance_re,"ssGSEA scores of KEGG for each celltype(* p<0.05)","KEGG");
	}else{
		//no sig
		function_infor_ssgsea_heatmap_nosig(advance_re,"ssGSEA scores of KEGG for each celltype","KEGG");
	}
	///////////7. function cellstat
	//table
	if(advance_re.cellstat_enrich_table_web !="empty"){
		function_infor_enrich_table(webpath+"/"+advance_re.cellstat_enrich_table_web,'tablecellstat');
		var downloadPath="download_loading.jsp?path="+webpath+"/"+advance_re.cellstat_enrich_table_download+"&name=cellstat_enrich_table_download.txt";
		document.getElementById('tablecellstat_download').href = downloadPath;
	}else{
		document.getElementById("tablecellstat").style.display="none";
		document.getElementById("cellstat-table").innerHTML="No sig result!";
	}
	//heatmap
	if(advance_re.cellstat_enrich_sig_pair !="empty"){
		//sig
		function_infor_ssgsea_heatmap_havesig(advance_re,"ssGSEA scores of cell stat for each celltype(* p<0.05)","cellstat");
	}else{
		//no sig
		function_infor_ssgsea_heatmap_nosig(advance_re,"ssGSEA scores of cell stat for each celltype","cellstat");
	}
	///////////8. function immue
	//table
	if(advance_re.immue_enrich_table_web !="empty"){
		function_infor_enrich_table(webpath+"/"+advance_re.immue_enrich_table_web,'tableimmue');
		var downloadPath="download_loading.jsp?path="+webpath+"/"+advance_re.immue_enrich_table_download+"&name=immue_enrich_table_download.txt";
		document.getElementById('tableimmue_download').href = downloadPath;
	}else{
		document.getElementById("tableimmue").style.display="none";
		document.getElementById("immue-table").innerHTML="No sig result!";
	}
	//heatmap
	if(advance_re.immue_enrich_sig_pair !="empty"){
		//sig
		function_infor_ssgsea_heatmap_havesig(advance_re,"ssGSEA scores of immune for each celltype(* p<0.05)","immue");
	}else{
		//no sig
		function_infor_ssgsea_heatmap_nosig(advance_re,"ssGSEA scores of immune for each celltype","immue");
	}
	///////////9. celltype xmselect
	// violin style
		var celltype_all=advance_re.violin_celltype.split(",");
		var color_all=advance_re.violin_color.split(",");
		var style_all_violin=[];
		for (var i=0;i<celltype_all.length;i++)
			{ 	var json0={};
				var json_value={};
				var json_color={};
				json_color["color"]=color_all[i];
				json_value["line"]=json_color;
				json0["target"]=celltype_all[i];
				json0["value"]=json_value;
				style_all_violin.push(json0);
			}
		//console.log(style_all_violin);
	//xmslect celltype
			var data_option=advance_re.celltype_unique.split(",");
			var data_option_valuearray = [];
			for (var i=0;i<data_option.length;i++)
						{ 
							json={}
							json['name']=data_option[i];
							json['value']=data_option[i];
							data_option_valuearray.push(json);
						}
			var e="#celltype_select";
			var demo1_gene = xmSelect.render({
				el: e, 
				size: 'big',//选中的之后显示的字的大小
				theme: {color: '#f0ad4e',},//主题颜色
				tips: 'Select a celltype for view',
				radio: true,
				clickClose: true,
				data: [],
				on: function(data){//监听
					var arr = data.arr;
					var change = data.change;
					//isAdd, 此次操作是新增还是删除
					var isAdd = data.isAdd;
					//
					var celltype_marker=eval("advance_re['"+arr[0]["value"]+"_marker"+"']").split(",");
					//1.marker
					celltypeMarkerXMselect(celltype_marker,style_all_violin,ats,webpath,annotationType);
					
							}
						})
				demo1_gene.update({
					data: data_option_valuearray
				})
			// 赋值
			demo1_gene.setValue([
				{name: data_option[0], value: data_option[0]},
				])
		//fist insert
		var celltype_first=data_option[0];
		var celltype_marker_first=eval("advance_re['"+celltype_first+"_marker"+"']").split(",");
		
		//1.marker
		celltypeMarkerXMselect(celltype_marker_first,style_all_violin,ats,webpath,annotationType);
		//2.tf
		if(advance_re.tf_infor=="yes"){
			var celltype_TF_first=eval("advance_re['"+celltype_first+"_tf"+"']").split(",");
		celltypeTFXMselect(celltype_first,celltype_TF_first,advance_re,ats+"_"+annotationType,webpath);
		}else{
			document.getElementById('TFnet').setAttribute("class","btn btn-warning span-advance-left-button-disable");
		}
		//3.rbp
		if(advance_re.rbp_infor=="yes"){
			var celltype_RBP_first=eval("advance_re['"+celltype_first+"_rbp"+"']").split(",");
			celltypeRBPXMselect(celltype_first,celltype_RBP_first,advance_re,ats+"_"+annotationType,webpath);
		}else{
			document.getElementById('RBPnet').setAttribute("class","btn btn-warning span-advance-left-button-disable");
		}
}
////////////////////////////////////////////////////////////////////method///////////////////////////////////////////////////////////////
//Advanced Analytics buttom
function chEvent(fun0){
	var function_b=["cellDensity","cellCycle","cellCorr","cellCellCom","celltypeMarker","TFnet","RBPnet","goEnrich","keggEnrich","cellstateEnrich","immEnrich"];
	for (var i=0;i<function_b.length;i++){
		//console.log(function_b[i]);
		if(fun0==function_b[i]){
			document.getElementById(function_b[i]+'Button').setAttribute("class","btn btn-warning span-advance-left-button-activate");
			document.getElementById(function_b[i]+'-content').style.display="block";
		}else{
			document.getElementById(function_b[i]+'Button').setAttribute("class","btn btn-warning span-advance-left-button");
			document.getElementById(function_b[i]+'-content').style.display="none";
		}
		}
}


var xml_annoType = xmSelect.render({
													el: '#xml_annoType',
													direction: 'up',//向上展开
													name: 'xml_annoType',//表单的name属性
													size: 'big',//选中的之后显示的字的大小
					                                theme: {color: '#f0ad4e',},//主题颜色
					                                tips: 'Select a type to view',
					                                style: {
					                            		marginLeft: '0px',
					                            		borderRadius: '10px',
					                            		height: '40px',
					                            		border: '1px solid #f0ad4e',
					                            	},
													radio: true,
													clickClose: true,
													data: [
														{name: ' Atlas annotation ', value: 'big',selected: true},
														{name: ' Finely annotated ', value: 'small'},														
													],
					                            	on: function(data){//监听					                            		
					                            		//arr:  当前多选已选中的数据
					                            		var arr = data.arr;
					                            		var change = data.change;
					                            		//isAdd, 此次操作是新增还是删除
					                            		var isAdd = data.isAdd;
					                            		var slectvalue=arr[0]["value"];
					                            		var daset=document.getElementById("daset").value;
														datasetContent(daset,slectvalue);

					                            		
					                            	}
})

var umap_select = xmSelect.render({
													el: '#umap_select',
													direction: 'up',//向上展开
													name: 'umap_select',//表单的name属性
													size: 'big',//选中的之后显示的字的大小
					                                theme: {color: '#f0ad4e',},//主题颜色
					                                tips: 'Select a type to view',
					                                style: {
					                            		marginLeft: '0px',
					                            		borderRadius: '10px',
					                            		height: '40px',
					                            		border: '1px solid #f0ad4e',
					                            	},
													radio: true,
													clickClose: true,
													data: [
														{name: ' Celltype annotation ', value: 'celltype',selected: true},
														{name: ' Cluster ', value: 'cluster'},														
													],
					                            	on: function(data){//监听					                            		
					                            		//arr:  当前多选已选中的数据
					                            		var arr = data.arr;
					                            		var change = data.change;
					                            		//isAdd, 此次操作是新增还是删除
					                            		var isAdd = data.isAdd;
					                            		var slectvalue=arr[0]["value"];
					                            		if(slectvalue=="celltype"){
					                            			tsen_umap_org(data_umap,shapes_umap,"umap","umap");
					                            		}else{
															tsen_umap_org(data_umap_cluster,shapes_umap_cluster,"umap","umap");
														}

					                            		
					                            	}
})


var tsne_select = xmSelect.render({
													el: '#tsne_select',
													direction: 'up',//向上展开
													name: 'tsne_select',//表单的name属性
													size: 'big',//选中的之后显示的字的大小
					                                theme: {color: '#f0ad4e',},//主题颜色
					                                tips: 'Select a type to view',
					                                style: {
					                            		marginLeft: '0px',
					                            		borderRadius: '10px',
					                            		height: '40px',
					                            		border: '1px solid #f0ad4e',
					                            	},
													radio: true,
													clickClose: true,
													data: [
														{name: ' Celltype annotation ', value: 'celltype',selected: true},
														{name: ' Cluster ', value: 'cluster'},														
													],
					                            	on: function(data){//监听					                            		
					                            		//arr:  当前多选已选中的数据
					                            		var arr = data.arr;
					                            		var change = data.change;
					                            		//isAdd, 此次操作是新增还是删除
					                            		var isAdd = data.isAdd;
					                            		var slectvalue=arr[0]["value"];
					                            		if(slectvalue=="celltype"){
					                            			tsen_umap_org(data_tsen,shapes_tsen,"tsne","tsne");
					                            		}else{
															tsen_umap_org(data_tsen_cluster,shapes_tsen_cluster,"tsne","tsne");
														}

					                            		
					                            	}
})

function function_infor_ssgsea_heatmap_havesig(jsonObject,img_title,function_type){
	var x_value=eval("jsonObject."+function_type+"_ssgsea_x_name").split(",");
	var y_value=eval("jsonObject."+function_type+"_ssgsea_y_name").split(",");
	var value_max=parseFloat(eval("jsonObject."+function_type+"_ssgsea_max")).toFixed(2);
	var value_min=parseFloat(eval("jsonObject."+function_type+"_ssgsea_min")).toFixed(2);
	var sig_pair=eval("jsonObject."+function_type+"_enrich_sig_pair").split(";");
	var z_all=eval("jsonObject."+function_type+"_ssgsea_z_value").split(";");
	var z_value=[];
	var hover_text=[];
	for (var i=0;i<z_all.length;i++){
		var z0=z_all[i].split(",");
		z_value.push(z0);
		//hover_text
		var h0=[];
		for ( var hh=0; hh<z0.length; hh++){
			h0.push(" Cell Type : "+x_value[hh]+" <br>"+" Pathway : "+y_value[hh]+" <br>"+" ssGSEA Score : "+z0[hh]+" ");
		}
		hover_text.push(h0);
	}
	
	ssgsea_heatmap_havesig(img_title,"Heatmap"+function_type,x_value,y_value,z_value,value_max,value_min,sig_pair,hover_text);
}


function function_infor_ssgsea_heatmap_nosig(jsonObject,img_title,function_type){
	var x_value=eval("jsonObject."+function_type+"_ssgsea_x_name").split(",");
	var y_value=eval("jsonObject."+function_type+"_ssgsea_y_name").split(",");
	var value_max=parseFloat(eval("jsonObject."+function_type+"_ssgsea_max")).toFixed(2);
	var value_min=parseFloat(eval("jsonObject."+function_type+"_ssgsea_min")).toFixed(2);
	//var sig_pair=eval("jsonObject."+function_type+"_enrich_sig_pair").split(";");
	var z_all=eval("jsonObject."+function_type+"_ssgsea_z_value").split(";");
	var z_value=[];
	var hover_text=[];
	for (var i=0;i<z_all.length;i++){
		var z0=z_all[i].split(",");
		z_value.push(z0);
		//hover_text
		var h0=[];
		for ( var hh=0; hh<z0.length; hh++){
			h0.push(" Cell Type : "+x_value[hh]+" <br>"+" Pathway : "+y_value[hh]+" <br>"+" ssGSEA Score : "+z0[hh]+" ");
		}
		hover_text.push(h0);
	}
	
	ssgsea_heatmap_nosig(img_title,"Heatmap"+function_type,x_value,y_value,z_value,value_max,value_min,hover_text);
}

function celltypeRBPXMselect(celltype_first,celltype_RBP_first,advance_re,ats,webpath){
	var data_option=celltype_RBP_first;
	var data_option_valuearray = [];
	for (var i=0;i<data_option.length;i++)
					{ 
						json={}
						json['name']=data_option[i];
						json['value']=data_option[i];
						data_option_valuearray.push(json);
					}
					var e="#RBP_select";
					var demo1_gene = xmSelect.render({
						el: e, 
						size: 'big',//选中的之后显示的字的大小
					    theme: {color: '#f0ad4e',},//主题颜色
						tips: 'Select a RBP for view',
						radio: true,
						clickClose: true,
						data: [],
						on: function(data){//监听
							var arr = data.arr;
							var change = data.change;
							//isAdd, 此次操作是新增还是删除
							var isAdd = data.isAdd;
							var rbp0=arr[0]["value"];
							///
							celltype0=xmSelect.get('#celltype_select', true).getValue('valueStr');
							circosCopyAndPlot(celltype0,rbp0,"RBP",ats,webpath);
							// table
							regTableCopyAndShow(celltype0,rbp0,"RBP",ats,webpath);
						}
					})
				 
					demo1_gene.update({
					data: data_option_valuearray
					})
		// 赋值
			demo1_gene.setValue([
			{name: data_option[0], value: data_option[0]},
			])
		//circos
		circosCopyAndPlot(celltype_first,data_option[0],"RBP",ats,webpath);
		// table
		regTableCopyAndShow(celltype_first,data_option[0],"RBP",ats,webpath);
}
function celltypeTFXMselect(celltype_first,celltype_TF_first,advance_re,ats,webpath){
	var data_option=celltype_TF_first;
	var data_option_valuearray = [];
	for (var i=0;i<data_option.length;i++)
					{ 
						json={}
						json['name']=data_option[i];
						json['value']=data_option[i];
						data_option_valuearray.push(json);
					}
					var e="#TF_select";
					var demo1_gene = xmSelect.render({
						el: e, 
						size: 'big',//选中的之后显示的字的大小
					    theme: {color: '#f0ad4e',},//主题颜色
						tips: 'Select a TF for view',
						radio: true,
						clickClose: true,
						data: [],
						on: function(data){//监听
							var arr = data.arr;
							var change = data.change;
							//isAdd, 此次操作是新增还是删除
							var isAdd = data.isAdd;
							var tf0=arr[0]["value"];
							///
							celltype0=xmSelect.get('#celltype_select', true).getValue('valueStr');
							circosCopyAndPlot(celltype0,tf0,"TF",ats,webpath);
							// table
							regTableCopyAndShow(celltype0,tf0,"TF",ats,webpath);
						}
					})
				 
					demo1_gene.update({
					data: data_option_valuearray
					})
		// 赋值
			demo1_gene.setValue([
			{name: data_option[0], value: data_option[0]},
			])
		//circos
		circosCopyAndPlot(celltype_first,data_option[0],"TF",ats,webpath);
		// table
		regTableCopyAndShow(celltype_first,data_option[0],"TF",ats,webpath);
		
		
}
function regTableCopyAndShow(celltype,reg,type,ats,webpath){
	var xmlHttp=new XMLHttpRequest();
	xmlHttp.onreadystatechange =function(){
		if(xmlHttp.readyState == 4 && xmlHttp.status == 200){
			var returnData=xmlHttp.responseText;
			var jsonobj=JSON.parse(returnData);
			if(jsonobj.error_attention=="no"){
				var path0="copyFile/table/"+celltype+"_"+reg+"_table.txt";
				if(type=="TF"){
				var oldTable = $('#tableTF').dataTable();
				oldTable.fnClearTable(); //清空一下table
				oldTable.fnDestroy(); //还原初始化了的dataTable
				regTable(path0,'tableTF');
				}else{
					var oldTable = $('#tableRBP').dataTable();
					oldTable.fnClearTable(); //清空一下table
					oldTable.fnDestroy(); //还原初始化了的dataTable
					regTable(path0,'tableRBP');
					}
			}
				}
			}
	param="ats="+ats+"&reg="+reg+"&type="+type+"&celltype="+celltype;
	xmlHttp.open("get","CopyTable.jsp?"+param,true);
	xmlHttp.send();
}
function circosCopyAndPlot(celltype,reg,type,ats,webpath){
	var xmlHttp=new XMLHttpRequest();
	xmlHttp.onreadystatechange =function(){
		if(xmlHttp.readyState == 4 && xmlHttp.status == 200){
			var returnData=xmlHttp.responseText;
			var jsonobj=JSON.parse(returnData);
			if(jsonobj.error_attention=="no"){
				var files0="copyFile/circos/"+celltype+"_"+reg+".json";
				if(type=="TF"){
				EcharCircosPlot_TF(files0,"tfCircos");
				}else{
					EcharCircosPlot_RBP(files0,"rbpCircos");
				}
			}
				}
			}
	param="ats="+ats+"&reg="+reg+"&type="+type+"&celltype="+celltype;
	xmlHttp.open("get","CopyCircos.jsp?"+param,true);
	xmlHttp.send();
}


function celltypeMarkerXMselect(celltype_marker,style_all_violin,ats,webpath,annotationType){
	var data_option=celltype_marker;
		var data_option_valuearray = [];
		for (var i=0;i<data_option.length;i++)
					{ 
						json={}
						json['name']=data_option[i];
						json['value']=data_option[i];
						data_option_valuearray.push(json);
					}
					var e="#marker_select";
					var demo1_gene = xmSelect.render({
						el: e, 
						size: 'big',//选中的之后显示的字的大小
					    theme: {color: '#f0ad4e',},//主题颜色
						tips: 'Select a marker gene for view',
						radio: true,
						clickClose: true,
						data: [],
						on: function(data){//监听
							var arr = data.arr;
							var change = data.change;
							//isAdd, 此次操作是新增还是删除
							var isAdd = data.isAdd;
							var marker0=arr[0]["value"];
							CopyViolinFileAndPlot(ats+"_"+annotationType,webpath,style_all_violin,marker0);
							geneFeaturePlot(ats+"_"+annotationType,marker0);
						}
					})
				 
					demo1_gene.update({
					data: data_option_valuearray
					})
		// 赋值
			demo1_gene.setValue([
			{name: data_option[0], value: data_option[0]},
			])
		//violin
		CopyViolinFileAndPlot(ats+"_"+annotationType,webpath,style_all_violin,data_option[0]);
		// feature plot////////////
		geneFeaturePlot(ats+"_"+annotationType,data_option[0]);
}

function geneFeaturePlot(ats,marker){
	var xmlHttp=new XMLHttpRequest();
	xmlHttp.onreadystatechange =function(){
		if(xmlHttp.readyState == 4 && xmlHttp.status == 200){
			var returnData=xmlHttp.responseText;
			var jsonobj=JSON.parse(returnData);
			if(jsonobj.error_attention=="no"){
				var tsne=jsonobj.tsne;
				var umap=jsonobj.umap;
				var max=jsonobj.max;
				//UMAP
				var umap_arr=umap.split("],");
				var umap_arr_use=[];
				for (var i=0;i<umap_arr.length-1;i++){
					arr0=[];
					str0=umap_arr[i].substr(1,umap_arr[i].length-1);
					str0_arr=str0.split(",");
					for (var j=0;j<str0_arr.length;j++){
						arr0.push(str0_arr[j]);
					}
					umap_arr_use.push(arr0);
				}
				EcharFeaturePlot(umap_arr_use,max,"markerFeatureUMAP","umap");
				//TSNE
				var tsne_arr=tsne.split("],");
				var tsne_arr_use=[];
				for (var i=0;i<tsne_arr.length-1;i++){
					arr0=[];
					str0=tsne_arr[i].substr(1,tsne_arr[i].length-1);
					str0_arr=str0.split(",");
					for (var j=0;j<str0_arr.length;j++){
						arr0.push(str0_arr[j]);
					}
					tsne_arr_use.push(arr0);
				}
				EcharFeaturePlot(tsne_arr_use,max,"markerFeaturetSNE","tsne");
			}
				}
			}
	param="ats="+ats+"&marker="+marker;
	xmlHttp.open("get","geneFeatureQuery.jsp?"+param,true);
	xmlHttp.send();
}

function CopyViolinFileAndPlot(ats,webpath,style_all_violin,marker){
	var xmlHttp=new XMLHttpRequest();
	xmlHttp.onreadystatechange =function(){
		if(xmlHttp.readyState == 4 && xmlHttp.status == 200){
			var returnData=xmlHttp.responseText;
			var jsonobj=JSON.parse(returnData);
			if(jsonobj.error_attention=="no"){
				var filepath0="copyFile/violin/"+marker+"_violin.csv";
				gene_infor_plotly_violin(filepath0,marker,style_all_violin,"markerViolin");
			}
				}
			}
	param="ats="+ats+"&marker="+marker;
	xmlHttp.open("get","violinCopy.jsp?"+param,true);
	xmlHttp.send();
}
function cellinfor_barplot_all(jsonObject,div){
		var bar_color=jsonObject.bar_polt_color.split(",");
		var bar_data=jsonObject.bar_polt_data.split(";");
		var bar_data_x=[];
		var bar_data_y=[];
		for (var i=0;i<bar_data.length;i++){
			var content=bar_data[i].split(",");
			bar_data_y.push(content[0]);
			bar_data_x.push(content[1]);
		}
		var plot_div=div;
		plotly_barplot(bar_data_x,bar_data_y,bar_color,plot_div);
	}
function cellCorr_heatmap_nosig(jsonObject,img_title,div){
	var x_value=eval("jsonObject.cellTypeCorrHeatmap_x_name").split(",");
	var y_value=eval("jsonObject.cellTypeCorrHeatmap_y_name").split(",");
	var value_max=parseFloat(eval("jsonObject.cellTypeCorrHeatmap_max")).toFixed(2);
	var value_min=parseFloat(eval("jsonObject.cellTypeCorrHeatmap_min")).toFixed(2);
	//var sig_pair=eval("jsonObject."+function_type+"_enrich_sig_pair").split(";");
	var z_all=eval("jsonObject.cellTypeCorrHeatmap_z_value").split(";");
	var z_value=[];
	var hover_text=[];
	for (var i=0;i<z_all.length;i++){
		var z0=z_all[i].split(",");
		z_value.push(z0);
		//hover_text
		var h0=[];
		for ( var hh=0; hh<z0.length; hh++){
			h0.push(" Cell Type : "+x_value[hh]+" <br>"+" Cell Type : "+y_value[hh]+" <br>"+" AUROC : "+z0[hh]+" ");
		}
		hover_text.push(h0);
	}
	
	plot_cellCorr_heatmap(img_title,div,x_value,y_value,z_value,value_max,value_min,hover_text);
}


////////////plot////////////
//ssgsea
function ssgsea_heatmap_nosig(title,div,x_value,y_value,z_value,value_max,value_min,hover_text){
	 var height="700px";
	 
		var x_left=150;
		if (div.match(RegExp(/GO_BP/))){
			height="1800px";
			x_left=350;
		}
		if (div.match(RegExp(/imm/))){
			x_left=300;
		}
		if (div.match(RegExp(/KEGG/))){
			x_left=300;
		}
	var width=$("#right-content").width();
	$("#"+div).css("width",width*0.98);
	$("#"+div).css("height",height);
	var xValues = x_value;
	var yValues = y_value;
	var zValues = z_value;

   var colorscaleValue = [
                          [0,'#FFFFFF'],
//                        [0.5, '#a84f9a'],
                        [1, '#bd2130']
   ];

   var data = [{
     
     x: xValues,
     y: yValues,
     z: zValues,
     type: 'heatmap',
     hovertext :hover_text,
     hoverinfo :"text",
     colorscale: colorscaleValue,
     automargin:true,
     showscale: true
   }
   ];

   var layout = {
	   showlegend: false,
   		margin: {"t": 80, "b": 150, "l": x_left, "r": 20}, //饼图边缘距离画布上下左右边界的距离，单位px
     title: title,
     font: {size: 15},
     xaxis: {
		    //title: '* mean sig',
       ticks: '',
       //side: ''
     },
     yaxis: {
       ticks: '',
       ticksuffix: ' ',
       autosize: false
     }
   };
	Plotly.newPlot(div, data, layout);
}

function ssgsea_heatmap_havesig(title,div,x_value,y_value,z_value,value_max,value_min,sig_pair,hover_text){
	var height="700px";
	
	var x_left=150;
	if (div.match(RegExp(/GO_BP/))){
		height="1800px";
		x_left=350;
	}
	if (div.match(RegExp(/imm/))){
		x_left=300;
	}
	if (div.match(RegExp(/KEGG/))){
			x_left=300;
		}
	var width=$("#right-content").width();
	$("#"+div).css("width",width*0.98);
	$("#"+div).css("height",height);
	var xValues = x_value;
   var yValues = y_value;
   var zValues = z_value;
//console.log(value_min+"   "+value_max+"hhh");
   var colorscaleValue = [
                          [0,'#FFFFFF'],
//                        [0.5, '#a84f9a'],
                        [1, '#bd2130']
   ];

   var data = [{
     
     x: xValues,
     y: yValues,
     z: zValues,
     type: 'heatmap',
     hovertext :hover_text,
     hoverinfo :"text",
     colorscale: colorscaleValue,
     automargin:true,
     showscale: true
   }
   ];

   var layout = {
	   
   		margin: {"t": 80, "b": 150, "l": x_left, "r": 20}, //饼图边缘距离画布上下左右边界的距离，单位px
     title: title,
     font: {size: 15},
     annotations: [],
     xaxis: {
		    //title: '* mean sig',
       ticks: '',
       //side: ''
     },
     yaxis: {
       ticks: '',
       ticksuffix: ' ',
       //width: 700,
      // height: 1000,
       autosize: false
     }
   };

   for ( var i = 0; i < yValues.length; i++ ) {
     for ( var j = 0; j < xValues.length; j++ ) {
       var currentValue = xValues[j]+","+yValues[i];
       if (sig_pair.includes(currentValue)) {
       	
         var textColor = 'white';
       
       var result = {
         xref: 'x1',
         yref: 'y1',
         x: xValues[j],
         y: yValues[i],
         text: '*',
         font: {
           family: 'Arial',
           size: 12,
           color: 'rgb(50, 171, 96)'
         },
         showarrow: false,
         font: {
           color: textColor
         }
       };
       }
       layout.annotations.push(result);
      
     }
   }

   Plotly.newPlot(div, data, layout);
}
//tf circos
function EcharCircosPlot_TF(files,div){
	var width=$("#right-content").width();
		$("#"+div).css("height",'600px');
		$("#"+div).css("width",width*0.95);
	var chartDom = document.getElementById(div);
	var myChart = echarts.init(chartDom);
	var option;

myChart.showLoading();
$.get(files, function (graph) {
	myChart.hideLoading();

    graph.nodes.forEach(function (node) {
        node.label = {
            show: node.symbolSize >0
        };
    });

    option = {
    		color:['#C93B35','#527F35',"#6699ff"],
//         title: {
//             text: 'Les Miserables',
//             subtext: 'Circular layout',
//             top: 'bottom',
//             left: 'right'
//         },
        tooltip: {},
        legend: [{ 
        	left: 'right',
            //orient: 'vertical',
            data: graph.categories.map(function (a) {
                return a.name;
            })
        }],
        animationDurationUpdate: 1500,
        animationEasingUpdate: 'quinticInOut',
        series: [
            {
                name: 'TF-target network',
                type: 'graph',
                layout: 'circular',
                circular: {
                    rotateLabel: true
                },
                data: graph.nodes,
                links: graph.links,
                categories: graph.categories,
                roam: true,
                label: {
                    position: 'right',
                    formatter: '{b}'
                },
                lineStyle: {
                    color: 'source',
                    curveness: 0.3
                }
            }
        ]
    };

    myChart.setOption(option);
});

option && myChart.setOption(option);
}
//rbp circos
function EcharCircosPlot_RBP(files,div){
	var width=$("#right-content").width();
		$("#"+div).css("height",'600px');
		$("#"+div).css("width",width*0.95);
	var chartDom = document.getElementById(div);
	var myChart = echarts.init(chartDom);
	var option;

myChart.showLoading();
$.get(files, function (graph) {
	myChart.hideLoading();

    graph.nodes.forEach(function (node) {
        node.label = {
            show: node.symbolSize >0
        };
    });

    option = {
    		color:['#C93B35','#527F35',"#6699ff"],
//         title: {
//             text: 'Les Miserables',
//             subtext: 'Circular layout',
//             top: 'bottom',
//             left: 'right'
//         },
        tooltip: {},
        legend: [{ 
        	left: 'right',
            //orient: 'vertical',
            data: graph.categories.map(function (a) {
                return a.name;
            })
        }],
        animationDurationUpdate: 1500,
        animationEasingUpdate: 'quinticInOut',
        series: [
            {
                name: 'RBP-target network',
                type: 'graph',
                layout: 'circular',
                circular: {
                    rotateLabel: true
                },
                data: graph.nodes,
                links: graph.links,
                categories: graph.categories,
                roam: true,
                label: {
                    position: 'right',
                    formatter: '{b}'
                },
                lineStyle: {
                    color: 'source',
                    curveness: 0.3
                }
            }
        ]
    };

    myChart.setOption(option);
});

option && myChart.setOption(option);
}
//gene feature
function EcharFeaturePlot(dataArray,max,div,type){
	if(type.match(RegExp(/tsne/))){t0="tSNE"}else{t0="UMAP"}
	var width=$("#right-content").width();
		$("#"+div).css("height",'600px');
		$("#"+div).css("width",width*0.5);
	var myChart = echarts.init(document.getElementById(div));
										data = dataArray;
										console.log(data);
										      var option = {
										        title: {
										          text: '',
										          left: 'center',
										          top: -5
										        },
										        legend: {},
										        visualMap: {
										          min: 0,
										          max: max,
										          right: 0,
										          top: 'center',
										          text: ['Expression', ''],
										          calculable: true,
										          inRange: {
										        	  color: ['#D3D3D5', '#2911FA']
										          }
										        },
										        tooltip: {
										          formatter: function (param) {
										        	  //console.log(param.data);
										            return ['Cell type : ' + param.data[2],'Expression : '+param.data[3]].join(
										              '<br/>'
										            );
										          }
										        },
										        grid:{
										        	top:"12%"
										        },
										        xAxis: [
										          {
										            type: 'value',
										            name: t0+'1',
										            nameLocation :"center"
										          }
										        ],
										        yAxis: [
										          {
										            type: 'value',
										            name: t0+'2',
										            nameLocation :"center"
										          }
										        ],
										        series: [
										          {
										
										            type: 'scatter',
										            symbolSize: 4,
										            data: data
										          }
										        ]
										      };
										      myChart.setOption(option);
										
										myChart.setOption(option);
}
//gene infor violin 
function gene_infor_plotly_violin(filepath,title,style_all,div){
	var filepath=filepath;
	var title_n=title;
	var style_all=style_all;
	var div=div;
	var width=$("#right-content").width();
	//$("#"+div).css("height",'600px');
	$("#"+div).css("width",width*0.95);
	
	d3.csv(filepath, function(err, rows){
  	  function unpack(rows, key) {
  	  return rows.map(function(row) { return row[key]; });
  	  }

  	var data = [{
  	  type: 'violin',
  	  x: unpack(rows, 'violin_x'),
  	  y: unpack(rows, 'violin_y'),
  	  points: 'none',//all
  	  box: {
  	    visible: true
  	  },
  	  meanline: {
  	    visible: true
  	  },
  	  transforms: [{
  	  	 type: 'groupby',
  		 groups: unpack(rows, 'violin_x'),
  		styles: style_all
  		 
  		}]
  	}]

  	var layout = {
	height: 600,
	
  	  title: title_n,
  	  yaxis: {
  		  //range: [0, 7800],
  		title:'Expression of marker',
  	    zeroline: true
  	  }
  	}

  	Plotly.newPlot(div, data, layout);
  	});
}
function plot_cellCorr_heatmap(title,div,x_value,y_value,z_value,value_max,value_min,hover_text){
		var x_left=150;
		var width=$("#right-content").width();
		//$("#"+div).css("height",'600px');
		$("#"+div).css("width",width*0.95);
	var xValues = x_value;
	var yValues = y_value;
	var zValues = z_value;

  var colorscaleValue = [
                         [0,'#FFFFFF'],
//                       [0.5, '#a84f9a'],
                       [1, '#bd2130']
  ];

  var data = [{
    
    x: xValues,
    y: yValues,
    z: zValues,
    type: 'heatmap',
    hovertext :hover_text,
    hoverinfo :"text",
    colorscale: colorscaleValue,
    automargin:true,
    showscale: true
  }
  ];

  var layout = {
  	margin: {"t": 80, "b": 150, "l": x_left, "r": 20}, //饼图边缘距离画布上下左右边界的距离，单位px
    title: title,
  	height: 600,
    font: {size: 15},
    xaxis: {
		    //title: '* mean sig',
      ticks: '',
      //side: ''
    },
    yaxis: {
      ticks: '',
      ticksuffix: ' ',
      autosize: false
    }
  };
	Plotly.newPlot(div, data, layout);
}
function plotyPielot(divName,value,labels,color,title){
	//var width=$("#bulk").width();
	//$("#"+divName).css("width",width*0.4);
	//自定义 hovertext
	var text1=[];
	for (var j=0;j<value.length;j++){
	text1.push(" Class :  "+labels[j]+"   <br>"+"Cell number : "+value[j]+"  ");
	}
	var data = [{
			values: value,
			labels: labels,
			  hovertext :text1,
			  hoverinfo :"text",
			//marker: {colors: color},
			type: 'pie'
				}];
		var layout = {
	  height: 600,
	  //width: 500,
	//title: title,
	  //showlegend: false,
	  font: {size: 15}
	   
	  
	};

	Plotly.newPlot(divName, data, layout);
}
function plotly_barplot(x,y,color,div){
	
	var x=x;
	var y=y;
	var color=color;
	var div=div;
	var width_bar=[];
	if (color.length>10){
		width_bar="";
	}else{
		for (var i=0;i<color.length;i++){
			width_bar.push(0.3);
		}
	}
	//自定义 hovertext
	var text1=[];
	for (var j=0;j<x.length;j++){
	text1.push(" Cell Type : "+x[j]+" <br>"+" Cell Number : "+y[j]+"  ");
	}
	//console.log(text1);
	var trace1 = {
			  x: x,
			  y: y,
			 // text: y.map(String),
			  //textposition: 'auto',
			  //hoverinfo: 'none',
			  width: width_bar,
			  hovertext :text1,
	          hoverinfo :"text",//"x", "y", "z", "text", "name" joined with a "+" OR "all" or "none" or "skip". Examples: "x", "y", "x+y", "x+y+z", "all"
			  marker:{
			    color: color
			  },
			  type: 'bar'
			};

			var data = [trace1];
			var layout = {
				yaxis: {
	        		    //range: [0, 8],
	        		    title: 'No. of Cells' ,
	        		    zeroline: true
	        		  
	        		  },
			  height: 600,
			  title: 'The number of cells belonging to each cell type',
			  font: {size: 15}
			};
			Plotly.newPlot(div, data, layout);
}

function tsen_umap_org(data,shapes,div,type){

	if(type.match(RegExp(/tsne/))){t0="tSNE"}else{t0="UMAP"}
	var data=data;
	var div=div;
	var layout = {
	       // shapes: shapes,
//	         height: 400,
//	         width: 480,
	        //showlegend: true,
	      title:t0,
	        	   	  legend: {
//	         	   	    bgcolor: 'white',
//	         	   	    borderwidth: 1,
//	         	   	    bordercolor: 'black',
//	         	   	    orientation: 'h',//h.v
//	         	   	    xanchor: 'center',
//	         	   	    x: 0,
	         	   	    //y:-0.2,
	        	   	    font: {
	        	   	      size: 14,
	        	   	    }
	        	   	  },
	        		  xaxis: {
	        		    //range: [ 0.75, 5.25 ],
	        		    title: t0+"1" ,
	        		    zeroline: true
	        		  },
	        		  yaxis: {
	        		    //range: [0, 8],
	        		    title: t0+"2" ,
	        		    zeroline: true
	        		  
	        		  }
	    }
	    Plotly.newPlot(div, data, layout);
}


function echars_River_cellcell(filepath,div){
	//获取父div的高度和宽；在display：none时得重新给且必须在表格加载前面
	var width=$("#right-content").width();
	$("#"+div).css("height",'600px');
	$("#"+div).css("width",width*0.95);
	var riverFilePath=filepath;
	//var chartDomPlotEcharsRiver = document.getElementById(div);
	//var myChartPlotEcharsRiver = echarts.init(chartDomPlotEcharsRiver);
	var myChartPlotEcharsRiver =echarts.init(document.getElementById(div), null, {renderer: 'svg'});	
	var optionPlotEcharsRiver;

	myChartPlotEcharsRiver.showLoading();
	$.get(riverFilePath, function (data) {
	    myChartPlotEcharsRiver.hideLoading();
	    myChartPlotEcharsRiver.setOption(optionPlotEcharsRiver = {
	    		toolbox: {
			          show: true,
			          left:"right",
			          feature: {			        	  
			              mark: {show: true},
			              //dataView: {show: true, readOnly: false},
			              //restore: {show: true},
			              saveAsImage: {show: true,
			            	  name:"Riverplot", 
			            	  title:"Save"}
			          }
			      },
	        title: {
	        	text: 'Details of cell-cell communication by ligand-receptor pairs',
		        left:'center'
	        },
//	        grid:{top:'10%'},
	        tooltip: {
	            trigger: 'item',
	            triggerOn: 'mousemove'
	            
	        },
	        series: [
	                 {
	                   type: 'sankey',
	                   //layoutIterations: 0 ,
	                   nodeAlign: 'left',
	                   data: data.nodes,
	                   links: data.links,
	                   emphasis: {
	                     focus: 'adjacency'
	                   },
	                   lineStyle: {
	                     color: 'gradient',
	                     curveness: 0.5
	                   },
	                   levels: [{
	                	    depth: 0,
	                	    itemStyle: {
	                	        color: '#fbb4ae'
	                	    },
	                	    lineStyle: {
	                	        color: 'source',
	                	        opacity: 0.1
	                	    }
	                	}]
	                 }
	               ]
	    });
	});
	optionPlotEcharsRiver && myChartPlotEcharsRiver.setOption(optionPlotEcharsRiver);
}
/////// data table //////////////
function regTable(path,div){
	var path=path;
	var div='#'+div;
	var oldTable = $(div).dataTable();
				oldTable.fnClearTable(); //清空一下table
				oldTable.fnDestroy(); //还原初始化了的dataTable
	$(document).ready(function() {
							    $(div).DataTable( {
							        dom: 'Bfrtip',
							        "deferRender": true,//big data
							        "bProcessing": true, //显示是否加载 
							        "paginationType": "full_numbers",//详细分页组，可以支持直接跳转到某页 
							        "lengthMenu": [10],    //选择每页显示多少条数据
							        "serverSide": false,      //后台处理分页则为true  
							        //"autoWidth": false,
							        //"autoHight": false,
							        "aaSorting": [[ 3, "desc" ]],//加载的时候按照第五列排序
							        //"aoColumnDefs": [ { "bSortable": false, "aTargets": [ 1 ] }],//禁止那些列排序 从0开始
							        
							        buttons: [
												{
												extend: 'excelHtml5',
												title: 'reg_re'
												},
												{
												extend: 'csvHtml5',
												title: 'reg_re'
												}
							            
							        ],
							        'ajax': path,
							        'columns':[{'data':'tf'},
							                   {'data':'cellnames'},
							                   {'data':'celltype'},
							                   {'data':'AUCscore'}
							                   ]
							    } );
							 
							  								  			
							} );

}
function cycle_table(path){
	var path=path;
	var oldTable = $('#tableCellCycle').dataTable();
				oldTable.fnClearTable(); //清空一下table
				oldTable.fnDestroy(); //还原初始化了的dataTable
	$(document).ready(function() {
		$('#tableCellCycle').DataTable( {
		"deferRender": true,//big data
		"bProcessing": true, //显示是否加载 
		"paginationType": "full_numbers",//详细分页组，可以支持直接跳转到某页 
		//'paging': false,
		"serverSide": false,      //后台处理分页则为true  
		"aaSorting": [[ 4, "desc" ]],
		'ordering'  :true,
		'ajax': path,
		'columns':[
					{'data':'cellname'},
					{'data':'cell_type'},
					{'data':'S_Score'},
					{'data':'G2M_Score'},
					{'data':'Phase'}
					]
		} );  
		} );
}
function celltypeCorr_table(path){
	var path=path;
	var oldTable = $('#tableCellCorr').dataTable();
	oldTable.fnClearTable(); //清空一下table
	oldTable.fnDestroy(); //还原初始化了的dataTable
	$(document).ready(function() {
		$('#tableCellCorr').DataTable( {
		"deferRender": true,//big data
		"bProcessing": true, //显示是否加载 
		"paginationType": "full_numbers",//详细分页组，可以支持直接跳转到某页 
		//'paging': false,
		"serverSide": false,      //后台处理分页则为true  
		"aaSorting": [[ 2, "desc" ]],
		'ordering'  :true,
		'ajax': path,
		'columns':[
					{'data':'cellType1'},
					{'data':'cellType2'},
					{'data':'AUROC'}
					]
		} );  
		} );
}

//cellcell communication
function cellcell_communication_table(path,div){
	var path=path;
	var div='#'+div;
	var oldTable = $(div).dataTable();
	oldTable.fnClearTable(); //清空一下table
	oldTable.fnDestroy(); //还原初始化了的dataTable
	$(document).ready(function() {												
		$(div).DataTable( {
		"deferRender": true,//big data
		"bProcessing": true, //显示是否加载 
		"paginationType": "full_numbers",//详细分页组，可以支持直接跳转到某页 
		"serverSide": false,      //后台处理分页则为true  
		'ajax': path,
		'columns':[{'data':'ligand'},
		{'data':'cell_from'},
		{'data':'Mean_exp1'},
		{'data':'receptor'},
		{'data':'cell_to'},
		{'data':'Mean_exp2'},
		{'data':'Function'},
		{'data':'score'}
		]
		} );  
		} );
}


//enrich infor
function function_infor_enrich_table(path,div){
	var path=path;
	var div='#'+div;
	var oldTable = $(div).dataTable();
				oldTable.fnClearTable(); //清空一下table
				oldTable.fnDestroy(); //还原初始化了的dataTable
	$(document).ready(function() {												
		$(div).DataTable( {
		"deferRender": true,//big data
		"bProcessing": true, //显示是否加载 
		"paginationType": "full_numbers",//详细分页组，可以支持直接跳转到某页 
		"serverSide": false,      //后台处理分页则为true  
		'ajax': path,
		'columns':[{'data':'Celltype'},
		{'data':'Pathway'},
		{'data':'P_value'},
		{'data':'FDR_value'},
		{'data':'intermarker',								                	   
			render: $.fn.enrich(3)}
		]
		} );  
		} );
	//返回部分值，按照逗号分隔的并且
	$.fn.enrich = function (cutoff) {
			return function (data, type, row) {
			if (type === 'display') {
				var str = data.toString(); // cast numbers
				var strArr=str.split(",")
				return strArr.length < cutoff ?
					strArr :
						"<span  title='" + str + "'>" + strArr.slice(0,3).join() + '&#8230;</span>';
						}
						return data;
						};
						};
}